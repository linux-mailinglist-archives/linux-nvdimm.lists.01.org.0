Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B89E1AD2EC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Apr 2020 00:48:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C1649100DCB80;
	Thu, 16 Apr 2020 15:48:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1CFE6100DCB7F
	for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 15:48:18 -0700 (PDT)
IronPort-SDR: WNAklTS8erR24J6Z89Yw8tWxVl4gZBozCX9934sD6K9VpLgpqrbenrK3cGRPCstPGQUHSb8BIS
 lq3rDT8Md1tQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 15:47:57 -0700
IronPort-SDR: SQZjQeAu61bCB8pqDDfXw+CrF5YH/Rdp2zuIFW0VB+89YMtXAfkqTfZnUZbgewJpXCU2PCNrF9
 msen8VtBrrPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200";
   d="scan'208";a="400836160"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga004.jf.intel.com with ESMTP; 16 Apr 2020 15:47:57 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.248]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.204]) with mapi id 14.03.0439.000;
 Thu, 16 Apr 2020 15:47:57 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com"
	<david@redhat.com>
Subject: Re: [PATCH v4] mm/memory_hotplug: refrain from adding memory into
 an impossible node
Thread-Topic: [PATCH v4] mm/memory_hotplug: refrain from adding memory into
 an impossible node
Thread-Index: AQHWFBHyHm1GdpEn1UCeVfs4v8Jy6ah8cauAgAAC5ACAAACWAIAAB84AgABSZIA=
Date: Thu, 16 Apr 2020 22:47:56 +0000
Message-ID: <a4a28e70d9fe25e514932099a8fd5a41eef51409.camel@intel.com>
References: <20200416171019.24433-1-vishal.l.verma@intel.com>
	 <185a067e-5864-100c-9a9a-6fd90f47ff43@redhat.com>
	 <0983dbe3a19d1a074a5959e91f315756ded4c90e.camel@intel.com>
	 <149f247e-173d-dcd5-3f68-f648bf18351c@redhat.com>
	 <6af5471c-8c41-e642-b20e-9c9d156cc754@redhat.com>
In-Reply-To: <6af5471c-8c41-e642-b20e-9c9d156cc754@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <AC9D944079D7DC4A9F9D8CAD1F1A94DE@intel.com>
MIME-Version: 1.0
Message-ID-Hash: WLAQTMRMF2XNEX5OEC2SVKNJFMXYOP5M
X-Message-ID-Hash: WLAQTMRMF2XNEX5OEC2SVKNJFMXYOP5M
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WLAQTMRMF2XNEX5OEC2SVKNJFMXYOP5M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2020-04-16 at 19:53 +0200, David Hildenbrand wrote:
> > > > 
> > > Hm, I'm happy to make the changes, but EINVAL to me suggests there is a
> > > problem in the way this was called by the user. And in this case there
> > > really might not be much the user can change in case fo buggy firmware.
> > 
> > Yeah, but introducing new return codes callers might not expected might
> > create IMHO other issues.
> > 
> > > Same thing with the WARN - make the potential firmware bug much more
> > > obvious and visible.
> > > 
> > 
> > Yeah, but I doubt this is really necessary. No strong feelings.
> > 
> 
> Forgot to
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
Thanks for the review David. I'll change the return code, and keep the
WARN, and send a new version.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
