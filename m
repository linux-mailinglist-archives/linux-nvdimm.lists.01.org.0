Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5341945D6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Mar 2020 18:51:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7369910FC3613;
	Thu, 26 Mar 2020 10:52:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2BCCB10FC3613
	for <linux-nvdimm@lists.01.org>; Thu, 26 Mar 2020 10:52:38 -0700 (PDT)
IronPort-SDR: rmX9KegEzNWRiZz2SLC8XbTRt8uv1W2+7aIYyIrX6glbp8akjNPJILBRtlsddIJSzvM8i8b120
 0gYnGDuZJcOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 10:51:47 -0700
IronPort-SDR: EzB4co+hzojIzsH/OdwRP7azAhlT6d2RO1xQzrP2hRL7j3gJRzuZsdoNmrjrUNYgI67iE/YCRa
 /PYbETPqjyag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200";
   d="scan'208";a="326642747"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2020 10:51:47 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 10:51:46 -0700
Received: from fmsmsx125.amr.corp.intel.com ([169.254.2.68]) by
 FMSMSX112.amr.corp.intel.com ([169.254.5.106]) with mapi id 14.03.0439.000;
 Thu, 26 Mar 2020 10:51:46 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Dorau, Lukasz"
	<lukasz.dorau@intel.com>
CC: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] ndctl/README: Add a missing config setting
Thread-Topic: [ndctl PATCH] ndctl/README: Add a missing config setting
Thread-Index: AdYDUHwforQEEX8ZSJ6r2fig7Jv/xQAgWaMA
Date: Thu, 26 Mar 2020 17:51:45 +0000
Message-ID: <3946efcd156cb89ee9f6f470c8ceab74388bf9a4.camel@intel.com>
References: <BN7PR11MB28495CCA929E46ADEB9B6B9296CF0@BN7PR11MB2849.namprd11.prod.outlook.com>
In-Reply-To: <BN7PR11MB28495CCA929E46ADEB9B6B9296CF0@BN7PR11MB2849.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.251.135.165]
Content-ID: <CC920C9E8E30A644A4A66397195271B7@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 367FHL75WOFGQG2N46S5S23O2JRX4F27
X-Message-ID-Hash: 367FHL75WOFGQG2N46S5S23O2JRX4F27
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/367FHL75WOFGQG2N46S5S23O2JRX4F27/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2020-03-26 at 09:25 +0000, Dorau, Lukasz wrote:
> Add a missing config setting to README.md:
> CONFIG_DEV_DAX_PMEM_COMPAT=m
> 
> Cc: Williams, Dan J <dan.j.williams@intel.com>
> Cc: Verma, Vishal L <vishal.l.verma@intel.com>
> Signed-off-by: Lukasz Dorau <lukasz.dorau@intel.com>
> ---
>  README.md | 1 +
>  1 file changed, 1 insertion(+)
> 
Thanks, looks good, I've pushed this out to a 'ld/readme' topic branch,
and it will make its way through pending and master.

	-Vishal
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
