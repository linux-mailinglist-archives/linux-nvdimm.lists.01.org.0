Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 340B5EE7EF
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Nov 2019 20:05:05 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE106100EA536;
	Mon,  4 Nov 2019 11:07:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A6025100EEBAC
	for <linux-nvdimm@lists.01.org>; Mon,  4 Nov 2019 11:07:49 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 11:04:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400";
   d="scan'208";a="200571000"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 04 Nov 2019 11:04:58 -0800
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX108.amr.corp.intel.com ([169.254.9.101]) with mapi id 14.03.0439.000;
 Mon, 4 Nov 2019 11:04:58 -0800
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH 2/2] ndctl/namespace: introduce
 ndctl_namespace_is_configurable()
Thread-Topic: [ndctl PATCH 2/2] ndctl/namespace: introduce
 ndctl_namespace_is_configurable()
Thread-Index: AQHVkPLFw8SdTlCdHE6Rdq8zm5J/NKd7v+sAgAAlFQCAAALjAIAAAdEA
Date: Mon, 4 Nov 2019 19:04:57 +0000
Message-ID: <d67d153b1d5e24814087477eeabf34fe908bdf80.camel@intel.com>
References: <20191101202713.5111-1-vishal.l.verma@intel.com>
	 <20191101202713.5111-2-vishal.l.verma@intel.com>
	 <CAPcyv4jWXXUgjd-_hsP+sUjBRfwQZQQOSUHUqSrdEYzfz3oS-g@mail.gmail.com>
	 <4e09051006f7714344c1d230061de0cfcb5377a9.camel@intel.com>
	 <CAPcyv4i5cqOrO6LLPZ2z5xx1xApbHaSvMiNk5CCQQ0ZxOr2hCQ@mail.gmail.com>
In-Reply-To: <CAPcyv4i5cqOrO6LLPZ2z5xx1xApbHaSvMiNk5CCQQ0ZxOr2hCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <7A21C74FE8BB824789965EA0FFF19003@intel.com>
MIME-Version: 1.0
Message-ID-Hash: AAGFD56ZAH2JZYVUJWZPAKA24ZWT4UCR
X-Message-ID-Hash: AAGFD56ZAH2JZYVUJWZPAKA24ZWT4UCR
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AAGFD56ZAH2JZYVUJWZPAKA24ZWT4UCR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2019-11-04 at 10:58 -0800, Dan Williams wrote:
> > 
> > > Also, how about s/ndctl_namespace_is_configurable/ndctl_namespace_is_configuration_idle/?
> > > Because to me all namespaces are always "configurable", but some may
> > > have active non-default properties set.
> > 
> > Sounds reasonable, but how about ndctl_namespace_has_partial_config(),
> > which I think describes the situation better, and makes it
> > straightforward for a potential future --really-force (or -ff) option
> > where we might still want to blow away anything on this namespace and
> > reclaim it.
> 
> Does "_has_partial_config()" imply "_has_full_config()"? In other
> words, what ndctl cares about are namespaces that can effectively be
> used as seeds with no existing configuration parameters having been
> set. So "_is_configuration_idle()" seems unambiguous where
> "_has_partial_config()" does not.

Good point, I'll go with _is_configuration_idle()
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
