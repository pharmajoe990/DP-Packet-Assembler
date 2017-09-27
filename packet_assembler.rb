#!/usr/bin/env ruby

$packet_pattern = /^(\d+)\s+(\d+)\s+(\d+)(.*)$/
$messages = {}

def parse_packet(packet)
	message_id = $packet_pattern.match(packet)[1].to_i
	packet_id = $packet_pattern.match(packet)[2].to_i
	num_packets = $packet_pattern.match(packet)[3].to_i
	text_hunk = $packet_pattern.match(packet)[4]
  if $messages[message_id]
    $messages[message_id][packet_id] = "#{message_id} #{packet_id} #{num_packets} #{text_hunk}"
  else
    $messages[message_id] = []
    $messages[message_id][packet_id] = "#{message_id} #{packet_id} #{num_packets} #{text_hunk}"
  end
end

def output()
  $messages.each do |hunk|
    hunk.each do |text|
      puts text
    end
  end
end

ARGF.each do |line|
 	parse_packet(line)
end

output