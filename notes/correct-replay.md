# When is a replay correct

- It always needs to return the same values to the hostcode
- It always needs to call the hostcode with the same arguments
- The call graph must be the same
- The calls logical timestamps must be the same
- Its memory size must always be the same as in the original execution
- Its table size must always be the same as in the original execution