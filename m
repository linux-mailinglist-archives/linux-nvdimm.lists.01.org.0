Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1CAF99A9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 20:23:25 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BED9B100EA628;
	Tue, 12 Nov 2019 11:25:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5E4A7100EA626
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 11:25:04 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 11:23:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400";
   d="scan'208";a="378984375"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2019 11:23:18 -0800
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.47]) by
 fmsmsx104.amr.corp.intel.com ([169.254.3.245]) with mapi id 14.03.0439.000;
 Tue, 12 Nov 2019 11:23:17 -0800
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH v2 1/2] ndctl/namespace: Rework counts reported by
 enable-namespace
Thread-Topic: [ndctl PATCH v2 1/2] ndctl/namespace: Rework counts reported
 by enable-namespace
Thread-Index: AQHVk/5RXwEQdD2e/kqHwdj/93yMgaeIe2MA
Date: Tue, 12 Nov 2019 19:23:17 +0000
Message-ID: <b8935e720b47a60e4b7ea75700b91be312ce6bfb.camel@intel.com>
References: <20191105172713.3628-1-vishal.l.verma@intel.com>
In-Reply-To: <20191105172713.3628-1-vishal.l.verma@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.4 (3.32.4-1.fc30) 
x-originating-ip: [10.232.112.164]
Content-ID: <BEAC7010595F594DA674CFC63B2AB115@intel.com>
MIME-Version: 1.0
Message-ID-Hash: NTOQIUGSKDSKXCGVSNJ5IQGQL56ASBS6
X-Message-ID-Hash: NTOQIUGSKDSKXCGVSNJ5IQGQL56ASBS6
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NTOQIUGSKDSKXCGVSNJ5IQGQL56ASBS6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Tue, 2019-11-05 at 10:27 -0700, Vishal Verma wrote:
> Add detection of 'seed' namespaces
> (ndctl_namespace_is_configuration_idle()) to the enable-namespace
> operatiuon and libndctl API. In libndctl, return a '1' for seed
> namespaces. In namespace.c, reinterpret a '1' based on a check for a
> seed namespace, and decide on skip vs success accordingly. Collect this
> into a new namespace_enable helper, and make the reported count
> consistent by also skipping namespaces that were already enabled.
> 
> Link: https://github.com/pmem/ndctl/issues/119
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
> 
> Changes in v2:
> - The kernel is the ultimate authority on enabling namespaces, so we
>   should let it make the decision of how to handle seed namespaces
>   instead of preemptively skipping them. Let the kernel make that
>   decision, and fix up error reporting after the fact.

These break the unit tests, so I'll have to take another look at this.
I suspect the added complexity is probably not worth the few extra
prints from seed namespaces for operations using the 'all' keyword.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
