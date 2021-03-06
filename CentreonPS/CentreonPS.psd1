#
# Manifeste de module pour le module « Centreon »
#
# Généré par : Florian Clisson
#
# Généré le : 08/07/2018
#

@{

# Module de script ou fichier de module binaire associé à ce manifeste
RootModule = 'CentreonPS.psm1'

# Numéro de version de ce module.
ModuleVersion = '1.0.0.1'

# Éditions PS prises en charge
# CompatiblePSEditions = @()

# ID utilisé pour identifier de manière unique ce module
GUID = '515246a6-7f95-412c-9a62-342f4a3ee915'

# Auteur de ce module
Author = 'Florian Clisson'

# Société ou fournisseur de ce module
CompanyName = 'Inconnu'

# Déclaration de copyright pour ce module
Copyright = '(c) 2018 Florian Clisson. All rights reserved. Licensed under The MIT License (MIT)'

# Description de la fonctionnalité fournie par ce module
Description = 'CentreonPS is a module to interact with the Centreon api'

# Version minimale du moteur Windows PowerShell requise par ce module
PowerShellVersion = '3.0'

# Nom de l'hôte Windows PowerShell requis par ce module
# PowerShellHostName = ''

# Version minimale de l'hôte Windows PowerShell requise par ce module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. Cette configuration requise est valide uniquement pour l'édition PowerShell de bureau.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. Cette configuration requise est valide uniquement pour l'édition PowerShell de bureau.
# CLRVersion = ''

# Architecture de processeur (None, X86, Amd64) requise par ce module
# ProcessorArchitecture = ''

# Modules qui doivent être importés dans l'environnement global préalablement à l'importation de ce module
# RequiredModules = @()

# Assemblys qui doivent être chargés préalablement à l'importation de ce module
# RequiredAssemblies = @()

# Fichiers de script (.ps1) exécutés dans l’environnement de l’appelant préalablement à l’importation de ce module
# ScriptsToProcess = @()

# Fichiers de types (.ps1xml) à charger lors de l'importation de ce module
# TypesToProcess = @()

# Fichiers de format (.ps1xml) à charger lors de l'importation de ce module
# FormatsToProcess = @()

# Modules à importer en tant que modules imbriqués du module spécifié dans RootModule/ModuleToProcess
# NestedModules = @()

# Fonctions à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucune fonction à exporter.
FunctionsToExport = @('New-CentreonConnection','Invoke-CentreonCommand','Get-CentreonHostStatus','Get-CentreonServiceStatus')

# Applets de commande à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucune applet de commande à exporter.
CmdletsToExport = '*'

# Variables à exporter à partir de ce module
VariablesToExport = '*'

# Alias à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucun alias à exporter.
AliasesToExport = '*'

# Ressources DSC à exporter depuis ce module
# DscResourcesToExport = @()

# Liste de tous les modules empaquetés avec ce module
# ModuleList = @()

# Liste de tous les fichiers empaquetés avec ce module
# FileList = @()

# Données privées à transmettre au module spécifié dans RootModule/ModuleToProcess. Cela peut également inclure une table de hachage PSData avec des métadonnées de modules supplémentaires utilisées par PowerShell.
PrivateData = @{

    PSData = @{

        # Des balises ont été appliquées à ce module. Elles facilitent la découverte des modules dans les galeries en ligne.
        Tags = @('Centreon', 'Centreon.com', 'Rest-Api')

        # URL vers la licence de ce module.
        LicenseUri = 'https://github.com/ClissonFlorian/Centreon-Powershell-Module/LICENSE.md'

        # URL vers le site web principal de ce projet.
        ProjectUri = 'https://github.com/ClissonFlorian/Centreon-Powershell-Module/'

        # URL vers une icône représentant ce module.
        # IconUri = ''

        # Propriété ReleaseNotes de ce module
        # ReleaseNotes = ''

    } # Fin de la table de hachage PSData

} # Fin de la table de hachage PrivateData

# URI HelpInfo de ce module
# HelpInfoURI = ''

# Le préfixe par défaut des commandes a été exporté à partir de ce module. Remplacez le préfixe par défaut à l’aide d’Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

