# -- Benchmark: loopFusion
# -- Variable independiente: Asociatividad de cache L1 de datos
# -- Variable dependiente:  sim_ticks 
# -- Tipo de CPU: TimingSimpleCPU

export META_BENCHMARK=loopFusion
export META_XAXIS="Tamaño de memoria de cache L1 de datos"
export META_YAXIS="sim_ticks"
export META_CPU_TYPE=TimingSimpleCPU
export META_FOLDER_NAME=loopTest
export META_WORK_DIR=/home/SharedData/loopTest



export GEM5_DIR=/code/GEM5/gem5 # Relativo al contenedor
export OPT=$GEM5_DIR/build/X86/gem5.opt
export PY=$GEM5_DIR/configs/example/se.py
export BENCHMARK=/home/SharedData/loopFusion # Relativo al contenedor
#export ARGUMENT=/code/parsec-2.1/pkgs/apps/$META_BENCHMARK/inputs/in_4.txt
xAxis=()
yAxis=()
for testIndex in 0 1 2 3
do
    #echo "Iteración ${testIndex}"
    (time $OPT -d "./${META_FOLDER_NAME}/m5out${testIndex}/"  $PY -c $BENCHMARK  --cpu-type=$META_CPU_TYPE --caches --l2cache "--l1d_size=$((2**testIndex))kB" --l1i_size=256kB --l2_size=1MB --l1d_assoc=2 --l1i_assoc=2 --l2_assoc=1 --cacheline_size=64) &> /dev/null 2>&1
    xAxis[${#xAxis[@]}]="$((2**testIndex))"
    yValue=$(cat "./${META_FOLDER_NAME}/m5out${testIndex}/stats.txt" | awk -F "=" '/sim_ticks/ {print $0}' | awk -F " " '{print $2}')
    yAxis[${#yAxis[@]}]="${yValue}"
done

{ echo "${xAxis[*]}"; echo "${yAxis[*]}"; } >./$META_FOLDER_NAME/plotResult
echo "Generando gráfico de prueba ${META_FOLDER_NAME}"
python3 viewer.py --xtitle "${META_XAXIS}"  --ytitle "${META_YAXIS}" --xscale "log" --yscale "linear" --xbase 2 --ybase 10 --inputfolder "${META_WORK_DIR}"
# cat ./test12/plotResult