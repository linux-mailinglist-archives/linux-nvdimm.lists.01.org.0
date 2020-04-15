Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4E41AB282
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Apr 2020 22:32:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 965BD10106334;
	Wed, 15 Apr 2020 13:32:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 429D610106333
	for <linux-nvdimm@lists.01.org>; Wed, 15 Apr 2020 13:32:30 -0700 (PDT)
IronPort-SDR: H36dZAvS2BuPVcW2L5d0uIvTUU1AjHzMbkdJDWGiqmtBGBTXqpOyy6jbmqSa7HpYh9qEdBrHsk
 f4vh/gu3PQtw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 13:32:02 -0700
IronPort-SDR: 3UqpvXs60xRINAa1mGU7FlJ1JMqIUlS/rgTrzXj2CwsX/g4axVNr/t+lNFxSWHxUGGyD7gsQ7I
 EtI8lvbTyNnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200";
   d="scan'208";a="288657186"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga002.fm.intel.com with ESMTP; 15 Apr 2020 13:32:01 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.248]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.15]) with mapi id 14.03.0439.000;
 Wed, 15 Apr 2020 13:32:01 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [PATCH v3] mm/memory_hotplug: refrain from adding memory into
 an impossible node
Thread-Topic: [PATCH v3] mm/memory_hotplug: refrain from adding memory into
 an impossible node
Thread-Index: AQHWEriRaezSbwIGuE+BiaITvAJR+Kh6dVgAgACkYQA=
Date: Wed, 15 Apr 2020 20:32:00 +0000
Message-ID: <7a37b7c03e983ceb32337325fa2a724fa614607b.camel@intel.com>
References: <20200414235812.6158-1-vishal.l.verma@intel.com>
	 <20200415104338.GF4629@dhcp22.suse.cz>
In-Reply-To: <20200415104338.GF4629@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <C817512205896942B025D6C61795DD46@intel.com>
MIME-Version: 1.0
Message-ID-Hash: XLD5MO5OK5FKZ5DRRLN46QQVI2KJQYQZ
X-Message-ID-Hash: XLD5MO5OK5FKZ5DRRLN46QQVI2KJQYQZ
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "david@redhat.com" <david@redhat.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XLD5MO5OK5FKZ5DRRLN46QQVI2KJQYQZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-04-15 at 12:43 +0200, Michal Hocko wrote:
> On Tue 14-04-20 17:58:12, Vishal Verma wrote:
> [...]
> > +static int check_hotplug_node(int nid)
> > +{
> > +	int alt_nid;
> > +
> > +	if (node_possible(nid))
> > +		return nid;
> > +
> > +	alt_nid = numa_map_to_online_node(nid);
> > +	if (alt_nid == NUMA_NO_NODE)
> > +		alt_nid = first_online_node;
> > +	WARN_TAINT(1, TAINT_FIRMWARE_WORKAROUND,
> > +		   "node %d expected, but was absent from the node_possible_map, using %d instead\n",
> > +		   nid, alt_nid);
> 
> I really do not like this. Why should we try to be clever and change the
> node id requested by the caller? I would just stick with node_possible
> check and be done with this.

Hi Michal,

Being clever allows us to still use the memory even if it is in a non-
optimal configuration. Failing here leaves the user no path to add this
memory until the firmware is fixed. It is the tradeoff between some
usability vs. how loud we want to be for the failure.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
