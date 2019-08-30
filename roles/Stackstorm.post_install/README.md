This role supports installing st2 packs from the configured indexes after install and smoke tests pass.

The three variables are:
# ST2 packs to be installed (list)
st2_packs: [azure]

# Installs py3 to support py3.6 packs
install_python_3: true

# ST2 packs to be installed which require py3. 
st2_packs_py3: [algosec]
