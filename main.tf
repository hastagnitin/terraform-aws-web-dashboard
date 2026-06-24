provider "aws" {
  region = var.aws_region
}

# Security Group Configuration
resource "aws_security_group" "web" {
  name        = "${var.environment}-web-sg"
  description = "Security group for web server in Mumbai"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-WebSecurityGroup"
    Environment = var.environment
  }
}


resource "aws_instance" "web_server" {
  ami                    = "ami-0522ab6e1ddcc7055" 
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx

              cat <<'HTML' > /var/www/html/index.html
              <!DOCTYPE html>
              <html lang="en">
              <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  <title>Cloud Deployment Dashboard</title>
                  <script src="https://cdn.tailwindcss.com"></script>
                  <style>
                      .neon-border { box-shadow: 0 0 10px rgba(34, 211, 238, 0.2), inset 0 0 10px rgba(34, 211, 238, 0.1); }
                      .neon-text { text-shadow: 0 0 8px rgba(34, 211, 238, 0.6); }
                      @keyframes pulse { 0%, 100% { transform: scale(1); opacity: 1; } 50% { transform: scale(1.3); opacity: 0.4; } }
                      .animate-pulse-slow { animation: pulse 2s infinite; }
                  </style>
              </head>
              <body class="bg-[#0f1115] text-zinc-100 font-sans min-h-screen flex items-center justify-center p-4 sm:p-6">
                  <div class="max-w-4xl w-full bg-[#181c24] border border-zinc-800 rounded-2xl shadow-2xl overflow-hidden neon-border">
                      <div class="bg-[#1e2330] border-b border-zinc-800 px-6 py-6 sm:px-8 flex flex-col sm:flex-row items-center justify-between gap-4">
                          <div class="flex items-center gap-4">
                              <div class="p-3 bg-zinc-900 rounded-xl border border-cyan-500/30">
                                  <svg class="w-8 h-8 text-cyan-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path></svg>
                              </div>
                              <div>
                                  <h1 class="text-xl sm:text-2xl font-black tracking-wider text-white uppercase">System Automated <span class="text-cyan-400 neon-text">//</span></h1>
                                  <p class="text-zinc-400 text-xs font-mono mt-0.5">Pipeline State: <span class="text-cyan-400">SUCCESSFUL</span></p>
                              </div>
                          </div>
                          <div class="flex items-center gap-2 bg-zinc-900 px-4 py-2 rounded-lg border border-zinc-800">
                              <span class="w-2.5 h-2.5 bg-cyan-400 rounded-full animate-pulse-slow shadow-[0_0_8px_#22d3ee]"></span>
                              <span class="text-xs font-mono text-zinc-300 uppercase tracking-widest">SYS_ACTIVE</span>
                          </div>
                      </div>
                      <div class="p-6 sm:p-8 grid grid-cols-1 sm:grid-cols-3 gap-6">
                          <div class="bg-[#1f2532] p-5 rounded-xl border border-zinc-800 hover:border-cyan-500/40 transition-all duration-300 flex flex-col justify-between h-40">
                              <div class="flex items-center justify-between"><span class="text-zinc-400 text-[10px] font-mono tracking-widest uppercase">Target Provider</span><img src="https://upload.wikimedia.org/wikipedia/commons/9/93/Amazon_Web_Services_Logo.svg" alt="AWS" class="h-5 invert opacity-80" /></div>
                              <div><div class="text-lg font-bold text-white tracking-tight">AWS Mumbai</div><div class="text-xs font-mono text-cyan-400 mt-1">ap-south-1</div></div>
                          </div>
                          <div class="bg-[#1f2532] p-5 rounded-xl border border-zinc-800 hover:border-cyan-500/40 transition-all duration-300 flex flex-col justify-between h-40">
                              <div class="flex items-center justify-between"><span class="text-zinc-400 text-[10px] font-mono tracking-widest uppercase">Deployment IaC</span><img src="https://upload.wikimedia.org/wikipedia/commons/0/04/Terraform_Logo.svg" alt="Terraform" class="h-6 opacity-90" /></div>
                              <div><div class="text-lg font-bold text-white tracking-tight">Terraform Engine</div><div class="text-xs font-mono text-zinc-400 mt-1">Status: <span class="text-emerald-400 font-bold">Stable</span></div></div>
                          </div>
                          <div class="bg-[#1f2532] p-5 rounded-xl border border-zinc-800 hover:border-cyan-500/40 transition-all duration-300 flex flex-col justify-between h-40">
                              <div class="flex items-center justify-between"><span class="text-zinc-400 text-[10px] font-mono tracking-widest uppercase">Web Service</span><img src="https://upload.wikimedia.org/wikipedia/commons/c/c5/Nginx_logo.svg" alt="Nginx" class="h-4 opacity-80" /></div>
                              <div><div class="text-lg font-bold text-white tracking-tight">Nginx Gateway</div><div class="text-xs font-mono text-zinc-400 mt-1">Config: <span class="text-cyan-400">user_data.sh</span></div></div>
                          </div>
                      </div>
                      <div class="px-6 sm:px-8 pb-6 sm:pb-8">
                          <div class="bg-[#0f1115] rounded-xl p-4 sm:p-5 border border-zinc-800/80 font-mono text-xs text-zinc-400 space-y-2 relative overflow-hidden">
                              <div class="absolute top-0 right-0 p-2 text-[10px] text-zinc-600 select-none">BASH</div>
                              <div class="flex items-center gap-2"><span class="text-cyan-500">$</span> <span class="text-zinc-300">terraform apply -auto-approve</span></div>
                              <div class="text-cyan-400/80 pl-4">ℹ Initializing automated structural verification...</div>
                              <div class="text-emerald-400 pl-4">✔ Deployment complete. URL generated successfully.</div>
                          </div>
                      </div>
                      <div class="bg-[#12151c] px-8 py-4 border-t border-zinc-800/60 text-center font-mono text-[10px] text-zinc-500 tracking-wider">SECURE IAC DEPLOYMENT ID: AP-SOUTH-1 // CLOUD-PRO-NODE</div>
                  </div>
              </body>
              </html>
              HTML
              EOF

  tags = {
    Name        = "${var.environment}-WebServer"
    Environment = var.environment
  }
}