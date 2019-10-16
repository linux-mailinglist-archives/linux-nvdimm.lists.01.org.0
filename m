Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3111BDA18E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Oct 2019 00:32:00 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AFF4010FCD1BE;
	Wed, 16 Oct 2019 15:34:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4ED0D10FCD1BE
	for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 15:34:54 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 15:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,305,1566889200";
   d="scan'208";a="195729672"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2019 15:31:54 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 16 Oct 2019 15:31:54 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 fmsmsx101.amr.corp.intel.com ([169.254.1.3]) with mapi id 14.03.0439.000;
 Wed, 16 Oct 2019 15:31:53 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>
Subject: Re: [PATCH] Consider namespace with size as active namespace
Thread-Topic: [PATCH] Consider namespace with size as active namespace
Thread-Index: AQHVTNoevSJkuNOO50uoHLwICBXdRqdevqaA
Date: Wed, 16 Oct 2019 22:31:52 +0000
Message-ID: <73abe6519435d3c0cfab32633c969b5efe16c0e4.camel@intel.com>
References: <20190807043915.30239-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190807043915.30239-1-aneesh.kumar@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <FA4AB70FAAEA5546B3CEF98C3DA33339@intel.com>
MIME-Version: 1.0
Message-ID-Hash: SOBL4AI2DDJUJMJ3POHXZXP2TQQBVUMA
X-Message-ID-Hash: SOBL4AI2DDJUJMJ3POHXZXP2TQQBVUMA
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SOBL4AI2DDJUJMJ3POHXZXP2TQQBVUMA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2019-08-07 at 10:09 +0530, Aneesh Kumar K.V wrote:
> This enables us to mark a namespace as disabled due to pfn_sb
> mismatch. We have pending kernel patches at that will mark the
> namespace disabled when the PAGE_SIZE or struct page size didn't
> match with the value stored in pfn_sb.
> 
> We need to make sure we don't use this disabled namespace as seed namespace
> for new namespace creation.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  ndctl/namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index 58a9e3c53474..1f212a2b3a9b 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -455,7 +455,8 @@ static int is_namespace_active(struct ndctl_namespace *ndns)
>  	return ndns && (ndctl_namespace_is_enabled(ndns)
>  		|| ndctl_namespace_get_pfn(ndns)
>  		|| ndctl_namespace_get_dax(ndns)
> -		|| ndctl_namespace_get_btt(ndns));
> +		|| ndctl_namespace_get_btt(ndns)
> +		|| ndctl_namespace_get_size(ndns));
>  }
>  
>  /*

Hi Aneesh,

I was going through pending ndctl patches and found this - this seems to
break some of the unit tests. Also, have the relevant kernel patches
been posted?

The failing unit tests are sector-mode.sh and dax.sh

	-Vishal
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
