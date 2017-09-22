FROM quay.io/refgenomics/docker-ubuntu:14.04

MAINTAINER Kenichi Chiba <kchiba@hgc.jp>

RUN apt-get update && \
    apt-get install -y \
           build-essential \
           zlib1g-dev \
           libbz2-dev \
           python-dev \
           libssl-dev \
           libncurses5-dev \
           gcc \
           make \
           wget \
           git

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN wget https://github.com/samtools/samtools/releases/download/1.2/samtools-1.2.tar.bz2 && \
    tar -xvf samtools-1.2.tar.bz2 && \
    cd samtools-1.2 && \
    make && make install && \
    mv samtools /bin/

RUN cd
RUN git clone https://github.com/Genomon-Project/GenomonFisher && \
	cd GenomonFisher && \
	git checkout v0.2.0 &&  \
        python setup.py build install

RUN cd
RUN git clone https://github.com/Genomon-Project/EBFilter && \
	cd EBFilter && \
	git checkout v0.2.1 &&  \
        python setup.py build install

ADD ./ctrl_panel_list.py /bin/

ADD ./main.sh /bin/

