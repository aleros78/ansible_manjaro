#!/bin/bash

# Trova tutti i file .yml nella cartella corrente
playbooks=(*.yml)

# Controlla se ci sono file YAML nella cartella
if [ ${#playbooks[@]} -eq 0 ]; then
    echo "Nessun file .yml trovato nella cartella corrente."
    exit 1
fi

# Mostra la lista dei playbook disponibili
echo "Seleziona un playbook da eseguire:"
for i in "${!playbooks[@]}"; do
    echo "$((i+1))) ${playbooks[$i]}"
done

# Chiede all'utente di selezionare un playbook
read -p "Inserisci il numero del playbook: " choice

# Controlla che la scelta sia valida
if [[ ! "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#playbooks[@]}" ]; then
    echo "Scelta non valida."
    exit 1
fi

# Seleziona il file corretto
selected_playbook="${playbooks[$((choice-1))]}"

# Esegui il playbook con Ansible
echo "Eseguendo: ansible-playbook -K $selected_playbook"
ansible-playbook -K "$selected_playbook"
