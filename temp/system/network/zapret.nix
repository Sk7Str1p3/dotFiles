{
  services.zapret = {
    enable = true;
    params = [
      "--dpi-desync=syndata,fake,split2 --dpi-desync-fooling=md5sig"
      "--dpi-desync=fake,tamper --dpi-desync-any-protocol"
    ];
    whitelist = [
      "discord.com"
      "gateway.discord.gg"
      "cdn.discordapp.com"
      "discordapp.net"
      "discordapp.com"
      "discord.gg"
      "media.discordapp.net"
      "images-ext-1.discordapp.net"
      "discord.app"
      "discord.media"
      "discordcdn.com"
      "discord.dev"
      "discord.new"
      "discord.gift"
      "discordstatus.com"
      "dis.gd"
      "discord.co"
      "discord-attachments-uploads-prd.storage.googleapis.com"
      "cloudflare-ech.com"
    ];
  };
}
