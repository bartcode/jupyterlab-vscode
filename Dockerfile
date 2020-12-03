FROM jupyter/scipy-notebook

RUN pip install net-tools

RUN pip install jupyterlab && \ 
    jupyter serverextension enable --py jupyterlab --sys-prefix

RUN pip install jupyter-server-proxy

 #jupyter labextension install jupyterlab-server-proxy && \
RUN cd /tmp/ && \
    git clone --depth 1 https://github.com/jupyterhub/jupyter-server-proxy && \
    cd jupyter-server-proxy/jupyterlab-server-proxy && \
    npm install && npm run build && jupyter labextension link . && \
    npm run build && jupyter lab build

# Download and install VS Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install the VS code proxy
ADD setup.py setup.py
ADD jupyter_vscode_proxy jupyter_vscode_proxy
ADD .vscode .vscode
ADD examples examples
ADD start start

RUN pip install .

ENTRYPOINT ["jupyter"]
CMD ["lab", "--no-browser"]
