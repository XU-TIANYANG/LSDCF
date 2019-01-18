LSDCF_repo_path = '#LOCATION';

tracker_label = 'LSDCF';
tracker_command = generate_matlab_command('benchmark_tracker_wrapper(''LSDCF'', ''VOT2018setting'', true)', {[LSDCF_repo_path '/VOT_integration/benchmark_wrapper']});
tracker_interpreter = 'matlab';