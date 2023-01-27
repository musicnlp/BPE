#!/usr/bin/python3 python

"""Runs metrics

"""
from pathlib import Path
import json
import logging

import numpy as np

from exp_gen import experiments
from metrics import overlapping_area_hist


def get_token_dist(files_path: Path):
    files_paths = list(files_path.glob('**/*.json'))

    tokens = []
    for file_path in files_paths:
        with open(file_path) as file:
            tokens += json.load(file)['tokens'][0]
    return tokens


if __name__ == '__main__':
    (out_dir := Path('analysis')).mkdir(parents=True, exist_ok=True)
    logger = logging.getLogger('oa_tokens_dataset_gen')
    logger.addHandler(logging.FileHandler(out_dir / 'oa_tokens_dataset_gen.log'))
    logger.addHandler(logging.StreamHandler())
    logger.setLevel(logging.DEBUG)

    # Get distributions of datasets
    for exp in experiments:
        logger.debug(f'\n{exp.name}')
        for baseline in exp.baselines:
            tokens_dist_dataset = get_token_dist(baseline.data_path)
            tokens_dist_gen_data = get_token_dist(baseline.gen_data_path)
            oa = overlapping_area_hist(np.array(tokens_dist_dataset), np.array(tokens_dist_gen_data))
            logger.debug(f'OA dataset-gen (hist intersection) {baseline.name}: {oa:.2f}')
