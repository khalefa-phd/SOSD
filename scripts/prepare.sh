#! /usr/bin/env bash
set -e

echo "Compiling benchmark..."
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j 

function generate_lookups() {
    echo "Generating lookups for $1"
    [ -f ../data/$1_equality_lookups_10M ] || ./generate ../data/$1 10000000
    [ -f ../data/$1_equality_lookups_1M ] || ./generate ../data/$1 1000000   
}

echo "Generating queries..."
generate_lookups normal_200M_uint32
generate_lookups normal_200M_uint64

echo "(stand by, this one takes a while...)"
generate_lookups lognormal_200M_uint32
generate_lookups lognormal_200M_uint64

generate_lookups uniform_dense_200M_uint32
generate_lookups uniform_dense_200M_uint64

generate_lookups uniform_sparse_200M_uint32
generate_lookups uniform_sparse_200M_uint64

generate_lookups osm_cellids_200M_uint64
generate_lookups wiki_ts_200M_uint64

generate_lookups books_200M_uint32
generate_lookups books_200M_uint64

generate_lookups fb_200M_uint64
generate_lookups fb_200M_uint32

