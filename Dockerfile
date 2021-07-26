FROM nvidia/cuda:11.1-cudnn8-devel-ubuntu20.04

# env variables
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Vancouver
SHELL ["/bin/bash", "-c"]

# Install system deps
RUN apt-get update -y && \
    apt-get install -y \
        wget \
        unzip \
        libgl1-mesa-dev \
        libgtk2.0-dev \
        python3-pip && \ 
    rm -rf /var/lib/apt/lists/*

# Install pytorch and pytorch scatter deps (need to match CUDA version)
RUN pip install --no-cache-dir torch==1.9+cu111 torchvision==0.10.0+cu111 \
    -f https://download.pytorch.org/whl/torch_stable.html

# Install all other python deps
RUN mkdir -p ggcnn/weights
COPY [ "./setup.py",  "ggcnn/setup.py" ]
RUN python3 -m pip install --no-cache-dir `python3 ggcnn/setup.py --list-reqs`

# Install repo
COPY [ ".",  "ggcnn/" ]
RUN python3 -m pip install --no-cache-dir ggcnn/

# Get weights and run eval
WORKDIR /ggcnn
RUN ./scripts/download_weights.sh
CMD python3 tools/eval_ggcnn.py --network weights/ggcnn2_weights_cornell/epoch_50_cornell_statedict.pt --dataset cornell --dataset-path /dataset --iou-eval
