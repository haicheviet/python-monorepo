coverage_files=$(find . -type f -name '*.coverage')
current_dir=$PWD
for coverage in $coverage_files
do
    echo "Reload coverage file $coverage"
    cd $( dirname $coverage)
    mv .coverage .coverage_temp
    coverage combine .coverage_temp
    cd $current_dir
done
coverage combine --keep $coverage_files