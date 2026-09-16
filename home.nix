{ ... }:

{
  home.username = "frace";
  home.homeDirectory = "/home/frace";

  home.stateVersion = "26.05";

  programs.bash.enable = true;

  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        padding = {
          x = 4;
          y = 4;
        };
      };

      font = {
        size = 10;
      };
    };
  };
}
