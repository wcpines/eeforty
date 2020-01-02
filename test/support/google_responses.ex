defmodule Eeforty.Support.GoogleResponses do
  def success_not_found do
    %Tesla.Env{
      __client__: %Tesla.Client{adapter: nil, fun: nil, post: [], pre: []},
      __module__: Tesla,
      body:
        "{\n   \"destination_addresses\" : [ \"4829 Corlett St, Tallahassee, FL 32302, USA\" ],\n   \"origin_addresses\" : [ \"\" ],\n   \"rows\" : [\n      {\n         \"elements\" : [\n            {\n               \"status\" : \"NOT_FOUND\"\n            }\n         ]\n      }\n   ],\n   \"status\" : \"OK\"\n}\n",
      headers: [
        {"content-type", "application/json; charset=UTF-8"},
        {"date", "Sun, 29 Dec 2019 15:13:27 GMT"},
        {"pragma", "no-cache"},
        {"expires", "Fri, 01 Jan 1990 00:00:00 GMT"},
        {"cache-control", "no-cache, must-revalidate"},
        {"server", "mafe"},
        {"x-xss-protection", "0"},
        {"x-frame-options", "SAMEORIGIN"},
        {"server-timing", "gfet4t7; dur=372"},
        {"alt-svc",
         "quic=\":443\"; ma=2592000; v=\"46,43\",h3-Q050=\":443\"; ma=2592000,h3-Q049=\":443\"; ma=2592000,h3-Q048=\":443\"; ma=2592000,h3-Q046=\":443\"; ma=2592000,h3-Q043=\":443\"; ma=2592000"},
        {"accept-ranges", "none"},
        {"vary", "Accept-Language,Accept-Encoding"},
        {"transfer-encoding", "chunked"}
      ],
      method: :get,
      opts: [],
      query: [
        origins: "fooaoeu",
        destinations: "barieoau",
        departure_time: "now"
      ],
      status: 200,
      url: "https://maps.googleapis.com/maps/api/distancematrix/json"
    }
  end

  def success do
    %Tesla.Env{
      __client__: %Tesla.Client{adapter: nil, fun: nil, post: [], pre: []},
      __module__: Tesla,
      body:
        "{\n   \"destination_addresses\" : [ \"Carpinteria, CA, USA\" ],\n   \"origin_addresses\" : [ \"Santa Barbara, CA, USA\" ],\n   \"rows\" : [\n      {\n         \"elements\" : [\n            {\n               \"distance\" : {\n                  \"text\" : \"17.9 km\",\n                  \"value\" : 17901\n               },\n               \"duration\" : {\n                  \"text\" : \"15 mins\",\n                  \"value\" : 895\n               },\n               \"duration_in_traffic\" : {\n                  \"text\" : \"13 mins\",\n                  \"value\" : 774\n               },\n               \"status\" : \"OK\"\n            }\n         ]\n      }\n   ],\n   \"status\" : \"OK\"\n}\n",
      headers: [
        {"content-type", "application/json; charset=UTF-8"},
        {"date", "Sun, 29 Dec 2019 14:45:32 GMT"},
        {"pragma", "no-cache"},
        {"expires", "Fri, 01 Jan 1990 00:00:00 GMT"},
        {"cache-control", "no-cache, must-revalidate"},
        {"server", "mafe"},
        {"x-xss-protection", "0"},
        {"x-frame-options", "SAMEORIGIN"},
        {"server-timing", "gfet4t7; dur=90"},
        {"alt-svc",
         "quic=\":443\"; ma=2592000; v=\"46,43\",h3-Q050=\":443\"; ma=2592000,h3-Q049=\":443\"; ma=2592000,h3-Q048=\":443\"; ma=2592000,h3-Q046=\":443\"; ma=2592000,h3-Q043=\":443\"; ma=2592000"},
        {"accept-ranges", "none"},
        {"vary", "Accept-Language,Accept-Encoding"},
        {"transfer-encoding", "chunked"}
      ],
      method: :get,
      opts: [],
      query: [
        origins: "Santa Barbara",
        destinations: "San Francisco",
        departure_time: "now"
      ],
      status: 200,
      url: "https://maps.googleapis.com/maps/api/distancematrix/json"
    }
  end

  def request_denied do
    %Tesla.Env{
      __client__: %Tesla.Client{adapter: nil, fun: nil, post: [], pre: []},
      __module__: Tesla,
      body:
        "{\n   \"destination_addresses\" : [],\n   \"error_message\" : \"The provided API key is invalid.\",\n   \"origin_addresses\" : [],\n   \"rows\" : [],\n   \"status\" : \"REQUEST_DENIED\"\n}\n",
      headers: [
        {"content-type", "application/json; charset=UTF-8"},
        {"date", "Sun, 29 Dec 2019 15:14:55 GMT"},
        {"pragma", "no-cache"},
        {"expires", "Fri, 01 Jan 1990 00:00:00 GMT"},
        {"cache-control", "no-cache, must-revalidate"},
        {"server", "mafe"},
        {"x-xss-protection", "0"},
        {"x-frame-options", "SAMEORIGIN"},
        {"server-timing", "gfet4t7; dur=11"},
        {"alt-svc",
         "quic=\":443\"; ma=2592000; v=\"46,43\",h3-Q050=\":443\"; ma=2592000,h3-Q049=\":443\"; ma=2592000,h3-Q048=\":443\"; ma=2592000,h3-Q046=\":443\"; ma=2592000,h3-Q043=\":443\"; ma=2592000"},
        {"accept-ranges", "none"},
        {"vary", "Accept-Language,Accept-Encoding"},
        {"transfer-encoding", "chunked"}
      ],
      method: :get,
      opts: [],
      query: [
        origins: "fooaoeu",
        destinations: "barieoau",
        departure_time: "now"
      ],
      status: 200,
      url: "https://maps.googleapis.com/maps/api/distancematrix/json"
    }
  end
end
