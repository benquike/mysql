# A fully secure / special-charactersy root password:
# MyPa$$wordHas_"Special\'Chars%!

def slave_1_cmd
  <<-EOF
/usr/bin/mysql \
-h 127.0.0.1 \
-P 3307 \
-u root \
-pMyPa\\$\\$word\\\\Has_\\\"Special\\'Chars\\%\\! \
-D databass \
-e "select * from table1"
  EOF
end

def slave_2_cmd
  <<-EOF
/usr/bin/mysql \
-h 127.0.0.1 \
-P 3308 \
-u root \
-pMyPa\\$\\$word\\\\Has_\\\"Special\\'Chars\\%\\! \
-D databass \
-e "select * from table1"
  EOF
end

describe command(slave_1_cmd) do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/awesome/) }
end

describe command(slave_2_cmd) do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/awesome/) }
end
