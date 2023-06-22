# Introduction

## Tips

### Autosave

Use a setting hat autosave your file.
To do it : 

1) CTRL+Maj+P
2) type "settings"
3) Select _Preferences : Open User settings (JSON)_
4) In the file, for the entry _files.autoSave_, set _afterDelay_

### Import not working in VS Code

In some contracts, import do not work.
For instance 

```solidity
import "forge-std/Test.sol";
```

is not working in a Test SC and VS code warns a error message.
To fix it, in the settings file (Cf above), add the following setting : 

```
"solidity.packageDefaultDependenciesDirectory": ["node_modules", "lib"]
```

Usually, only _node_modules_ are present. Add _lib_.
Then, re-launch VS Code




