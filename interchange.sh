export META_XAXIS="Tamaño de la matriz"
export META_YAXIS="sim_ticks"
export GEM5_DIR=/code/GEM5/gem5 # Relativo al contenedor
export OPT=$GEM5_DIR/build/X86/gem5.opt
export PY=$GEM5_DIR/configs/example/se.py
export BENCHMARK=/home/SharedData/baseLoopInterchange # Relativo al contenedor
export BENCHMARK2=/home/SharedData/optLoopInterchange # Relativo al contenedor
export META_CPU_TYPE=TimingSimpleCPU
export META_FOLDER_NAME=loopInterchangeTest
export META_WORK_RESULTS=/home/SharedData/loopInterchangeTest
export META_WORK_DIR_BASE=/home/SharedData/loopInterchangeTest/interchangeBase
export META_WORK_DIR_OPT=/home/SharedData/loopInterchangeTest/interchangeOpt
# size of array base code
xBaseAxis=()
# number of ticks
yBaseAxis=()

# size of array improved code
xOptAxis=()
# number of ticks
yOptAxis=()

for testIndex in 1 2 3 4 5 6
do
echo "Simulación con matriz de $((2**testIndex)) x $((2**testIndex))"
(time $OPT -d "./${META_FOLDER_NAME}/interchangeBase/m5out${testIndex}/"  $PY -c $BENCHMARK -o $((2**testIndex)) --cpu-type=$META_CPU_TYPE --caches --l2cache --l1d_size=256kB --l1i_size=256kB --l2_size=1MB --l1d_assoc=2 --l1i_assoc=2 --l2_assoc=1 --cacheline_size=64) &> /dev/null 2>&1
(time $OPT -d "./${META_FOLDER_NAME}/interchangeOpt/m5out${testIndex}/"  $PY -c $BENCHMARK2 -o $((2**testIndex)) --cpu-type=$META_CPU_TYPE --caches --l2cache --l1d_size=256kB --l1i_size=256kB --l2_size=1MB --l1d_assoc=2 --l1i_assoc=2 --l2_assoc=1 --cacheline_size=64) &> /dev/null 2>&1
xBaseAxis[${#xBaseAxis[@]}]="$((2**testIndex))"
xOptAxis[${#xOptAxis[@]}]="$((2**testIndex))"

yValueBase=$( cat "$META_WORK_DIR_BASE/m5out${testIndex}/stats.txt" | awk -F "=" '/sim_ticks/ {print $0}' | awk -F " " '{print $2}' )
yValueOpt=$( cat "$META_WORK_DIR_OPT/m5out${testIndex}/stats.txt" | awk -F "=" '/sim_ticks/ {print $0}' | awk -F " " '{print $2}' )
yBaseAxis[${#yBaseAxis[@]}]="${yValueBase}"
yOptAxis[${#yOptAxis[@]}]="${yValueOpt}"
done
touch $META_WORK_DIR_BASE/plotResult
touch $META_WORK_DIR_OPT/plotResult
{ echo "${xBaseAxis[*]}"; echo "${yBaseAxis[*]}"; } >$META_WORK_DIR_BASE/plotResult
{ echo "${xOptAxis[*]}"; echo "${yOptAxis[*]}"; } >$META_WORK_DIR_OPT/plotResult

echo "Generando gráfico de prueba ${META_FOLDER_NAME}"
python3 viewer.py --xtitle "${META_XAXIS}"  --ytitle "${META_YAXIS}" --xscale "log" --yscale "linear" --xbase 2 --ybase 10 --inputfolder "$META_WORK_RESULTS"
#python3 viewer.py --xtitle "${META_XAXIS}"  --ytitle "${META_YAXIS} Improved" --xscale "log" --yscale "linear" --xbase 2 --ybase 10 --inputfolder "$META_WORK_DIR_OPT"