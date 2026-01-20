[← Index](index.html)

# 3\. Package format: `nhoid`

The `nhoid` file is the core of any nhopkg package. It defines metadata, dependencies, sources, and behavior.

## Format version
    
    
    #%NHO-0.5

## Common fields

Field| Description  
---|---  
`# Name:`| Package name  
`# Version:`| Software version  
`# Release:`| Package release number  
`# Description:`| Short description  
`# Arch:`| Target architecture  
  
## Post-install functions

  * `npostinstall()`
  * `npostremove()`


