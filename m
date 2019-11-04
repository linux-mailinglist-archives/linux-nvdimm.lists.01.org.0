Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F10EE7A2
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Nov 2019 19:48:11 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A93B2100EA53E;
	Mon,  4 Nov 2019 10:50:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AFD8C100EA536
	for <linux-nvdimm@lists.01.org>; Mon,  4 Nov 2019 10:50:57 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 10:48:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400";
   d="scan'208";a="205254517"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga006.jf.intel.com with ESMTP; 04 Nov 2019 10:48:08 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 4 Nov 2019 10:48:07 -0800
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 fmsmsx115.amr.corp.intel.com ([169.254.4.204]) with mapi id 14.03.0439.000;
 Mon, 4 Nov 2019 10:48:07 -0800
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH 2/2] ndctl/namespace: introduce
 ndctl_namespace_is_configurable()
Thread-Topic: [ndctl PATCH 2/2] ndctl/namespace: introduce
 ndctl_namespace_is_configurable()
Thread-Index: AQHVkPLFw8SdTlCdHE6Rdq8zm5J/NKd7v+sAgAAlFQA=
Date: Mon, 4 Nov 2019 18:48:06 +0000
Message-ID: <4e09051006f7714344c1d230061de0cfcb5377a9.camel@intel.com>
References: <20191101202713.5111-1-vishal.l.verma@intel.com>
	 <20191101202713.5111-2-vishal.l.verma@intel.com>
	 <CAPcyv4jWXXUgjd-_hsP+sUjBRfwQZQQOSUHUqSrdEYzfz3oS-g@mail.gmail.com>
In-Reply-To: <CAPcyv4jWXXUgjd-_hsP+sUjBRfwQZQQOSUHUqSrdEYzfz3oS-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <EC15411052738547878BC5181DFC2C5A@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 4BKOA2MP7GA726EM43Q75WRJR5JW43XH
X-Message-ID-Hash: 4BKOA2MP7GA726EM43Q75WRJR5JW43XH
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4BKOA2MP7GA726EM43Q75WRJR5JW43XH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2019-11-04 at 08:35 -0800, Dan Williams wrote:
> On Fri, Nov 1, 2019 at 1:27 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > The motivation for this change is that we want to refrain from
> > (re)configuring what appear to be partially configured namespaces.
> > Namespaces may end up in a state that looks partially configured when
> > the kernel isn't able to enable a namespace due to mismatched
> > PAGE_SIZE expectations. In such cases, ndctl should not treat those
> > as unconfigured 'seed' namespaces, and reuse them.
> > 
> > Add a new ndctl_namespace_is_configurable API, whish tests whether a
> > namespaces is active, and whether it is partially configured. If neither
> > are true, then it can be used for (re)configuration. Additionally, deal
> > with the corner case of ND_DEVICE_NAMESPACE_IO (legacy PMEM) namespaces
> > by testing whether the size attribute is read-only (which indicates such
> > a namespace). Legacy namespaces always appear as configured, since their
> > size cannot be changed, but they are also always re-configurable.
> > 
> > Use this API in namespace_reconfig() and namespace_create() to enable
> > this partial configuration detection.
> 
> A couple comments.... I think it's probably sufficient to just check
> for ND_DEVICE_NAMESPACE_IO as I don't anticipate we'll ever have more
> than one namespace type with a read-only size attribute.

Yep I did notice I could do that, but I decided to go to the source of
it instead of adding another ND_DEVICE_NAMESPACE_IO assumption. Also I
had already written sysfs_attr_writable() before I noticed that :)
But there are already assumptions around ND_DEVICE_NAMESPACE_IO, so
adding another one here is fine.

> Also, how about s/ndctl_namespace_is_configurable/ndctl_namespace_is_configuration_idle/?
> Because to me all namespaces are always "configurable", but some may
> have active non-default properties set.

Sounds reasonable, but how about ndctl_namespace_has_partial_config(),
which I think describes the situation better, and makes it
straightforward for a potential future --really-force (or -ff) option
where we might still want to blow away anything on this namespace and
reclaim it.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
