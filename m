Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B81F1ACE98
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Apr 2020 19:23:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E4F69100DCB77;
	Thu, 16 Apr 2020 10:23:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6376E100DCB76
	for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 10:23:26 -0700 (PDT)
IronPort-SDR: crxagiJKBHQJzgsJp2VUozrRYsq8+h2qSQ0Lvizzsm3ICqLcqHxZwN2RPayV47w1t70raFUENT
 jqEGgtTmE5yw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 10:23:03 -0700
IronPort-SDR: TtICVRFxr8omhWG7eWAvZKsYLfyB0Klbfbj7OPJOkqmTZutCxC7cuHwZirheInxkP8pP4uOJKN
 faMWrfuCO7uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200";
   d="scan'208";a="246049355"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2020 10:23:03 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.248]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.204]) with mapi id 14.03.0439.000;
 Thu, 16 Apr 2020 10:23:02 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com"
	<david@redhat.com>
Subject: Re: [PATCH v4] mm/memory_hotplug: refrain from adding memory into
 an impossible node
Thread-Topic: [PATCH v4] mm/memory_hotplug: refrain from adding memory into
 an impossible node
Thread-Index: AQHWFBHyHm1GdpEn1UCeVfs4v8Jy6ah8cauAgAAC5AA=
Date: Thu, 16 Apr 2020 17:23:02 +0000
Message-ID: <0983dbe3a19d1a074a5959e91f315756ded4c90e.camel@intel.com>
References: <20200416171019.24433-1-vishal.l.verma@intel.com>
	 <185a067e-5864-100c-9a9a-6fd90f47ff43@redhat.com>
In-Reply-To: <185a067e-5864-100c-9a9a-6fd90f47ff43@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <0CA0E2766FF85446A655447412289D66@intel.com>
MIME-Version: 1.0
Message-ID-Hash: XJYMETQHKIACK3MER5K3RT6EF3TI4JM6
X-Message-ID-Hash: XJYMETQHKIACK3MER5K3RT6EF3TI4JM6
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XJYMETQHKIACK3MER5K3RT6EF3TI4JM6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2020-04-16 at 19:12 +0200, David Hildenbrand wrote:
> On 16.04.20 19:10, Vishal Verma wrote:
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 0a54ffac8c68..ddd3347edd54 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1005,6 +1005,11 @@ int __ref add_memory_resource(int nid, struct resource *res)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (!node_possible(nid)) {
> > +		WARN(1, "node %d was absent from the node_possible_map\n", nid);
> > +		return -ENXIO;
> 
> Nit: I suggest using "-EINVAL" instead (e.g., returned via
> check_hotplug_memory_range).
> 
> Not sure if we should pr_err() instead of WARN (see e.g.,
> check_hotplug_memory_range)
> 
Hm, I'm happy to make the changes, but EINVAL to me suggests there is a
problem in the way this was called by the user. And in this case there
really might not be much the user can change in case fo buggy firmware.

Same thing with the WARN - make the potential firmware bug much more
obvious and visible.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
