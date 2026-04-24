{ pkgs }:
{
  lean = pkgs.mkShell {
    packages = with pkgs; [
      elan
      cloc
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions; [
          pkief.material-icon-theme
          leanprover.lean4
          tamasfe.even-better-toml
        ];
      })
    ];
  };
}
