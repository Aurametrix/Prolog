require 'aws-sdk'

def typed_value(value, typ, context)
  context << "type(\"#{value}\", #{typ})."
end

def link(source, target, context)
  context << "link(\"#{source}\", \"#{target}\")."
end

def get_security_groups(instance_id, groups, context) 
  groups.each do |group|
    typed_value(group_id = group.group_id, 'security_group', context)
    link(instance_id, group_id, context)
  end
end

context = []
ec2 = Aws::EC2::Resource.new(region: 'us-west-2')

ec2.instances.each do |i|
  typed_value(instance_id = i.data.instance_id, 'ec2_instance', context)
  get_security_groups(instance_id, i.data.security_groups, context)
end

sgs = Aws::EC2::Client.new(region: 'us-west-2').describe_security_groups
sgs.security_groups.each do |security_group|
  typed_value(group_id = security_group.group_id,
    'security_group', context)
  typed_value(group_name = security_group.group_name,
    'sg_name', context)
  link(group_id, group_name, context)
  security_group.ip_permissions.each do |ip_permission|
    ip_permission.user_id_group_pairs.each do |group_pair|
      link(group_id, group_pair.group_id, context)
    end
  end
end

File.open('graph.pl', 'w') { |f| f.puts context.sort.uniq.join("\n") }
