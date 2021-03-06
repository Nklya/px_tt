# encoding: utf-8
# copyright: 2018, Nikolay Antsiferov

host = attribute ('app_host')
port = 80

control 'app-1.0' do
  title 'Check application ext'

  describe host(host, port: port, protocol: 'tcp') do
    it { should be_reachable }
  end

  describe http("http://#{host}/?n=8") do
    its('status') { should eq 200 }
    its('body') { should match ('0 1 1 2 3 5 8 13') }
  end

  # This test is disabled due to enabled blocking code
  # describe http("http://#{host}/blacklisted/") do
  #   its('status') { should eq 444 }
  # end
end
