Write-Host "Setting Environment variables"

function IsVarExists {
    param (
        [string]$variableName
    )
    
    if (Get-Variable $variableName -Scope 'Global' -ErrorAction 'Ignore') {
        return $true
    } else {
        return $false
    }
}

function getVariableSafe {
    param (
        [string]$variableName
    )
    
    return (Get-Variable $variableName -Scope 'Global' -ErrorAction 'Ignore') 
}

function Get-VariableSafe2 {
    param (
        [string]$variableName
    )
    
    $variable = Get-Variable $variableName -Scope 'Global' -ErrorAction 'Ignore'
    if ($null -ne $variable) {
        return $variable.Value
    } else {
        return 'bob' # $null
    }
}

function Set-EnvVariableIfNotSet {
    param(
        [string]$variableName,
        [string]$variableValue
    )

    # Check if the environment variable is not set
    
    if (-not $variableName) {
        # Set environment variable
        Set-Variable $variableName -Scope 'Global' -Value $variableValue
        Write-Host "Environment variable '$variableName' set to '$variableValue'"
    }
    else {
        $envVariableValue = Get-VariableSafe2 -variableName $variableName
        Write-Host "Environment variable '$variableName' already has a value: '$envVariableValue'"
    }
}

Set-EnvVariableIfNotSet -variableName "APP_ENVIRONMENT" -variableValue 'local'
Set-EnvVariableIfNotSet -variableName "APP_NAME" -variableValue 'my_app'
Set-EnvVariableIfNotSet -variableName "APP_VERSION" -variableValue '1.0.2'

# $env:APP_ENVIRONMENT = 'local'
# $env:APP_NAME='incident-spoke'
# $env:APP_VERSION = '1.0.2'

Write-Host "I'm done! Setting Environment variables"
