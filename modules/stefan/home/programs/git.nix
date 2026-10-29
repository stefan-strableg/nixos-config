{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Stefan Strableg";
      user.email = "stefan@strableg.at";
      diff.tool = "vscode";
      difftool.vscode.cmd = "${pkgs.vscode}/bin/code --wait --diff $LOCAL $REMOTE";
      init.defaultBranch = "main";
    };
  };
}
