Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F47B02B9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Sep 2019 19:34:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A0C9721962301;
	Wed, 11 Sep 2019 10:34:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7F238202BB9B9
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 10:34:18 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Sep 2019 10:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; d="scan'208";a="384774516"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga005.fm.intel.com with ESMTP; 11 Sep 2019 10:34:08 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Sep 2019 10:34:08 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.68]) by
 FMSMSX114.amr.corp.intel.com ([169.254.6.218]) with mapi id 14.03.0439.000;
 Wed, 11 Sep 2019 10:34:08 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH v2 2/3] Maintainer Handbook:
 Maintainer Entry Profile
Thread-Topic: [Ksummit-discuss] [PATCH v2 2/3] Maintainer Handbook:
 Maintainer Entry Profile
Thread-Index: AQHVaLpqINt3BK3afk2+UTXTBVR/lqcnMh2A
Date: Wed, 11 Sep 2019 17:34:08 +0000
Message-ID: <78b0d48ac797d565b0dd98de02fc21bd2ce5769a.camel@intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <E8972A5658F548449D6EC7503DE2C959@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "ksummit-discuss@lists.linuxfoundation.org"
 <ksummit-discuss@lists.linuxfoundation.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "dvyukov@google.com" <dvyukov@google.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "stfrench@microsoft.com" <stfrench@microsoft.com>, "me@tobin.cc" <me@tobin.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 2019-09-11 at 08:48 -0700, Dan Williams wrote:

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3f171339df53..e5d111a86e61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -98,6 +98,10 @@ Descriptions of section entries:
>  	   Obsolete:	Old code. Something tagged obsolete generally means
>  			it has been replaced by a better system and you
>  			should be using that.
> +	P: Subsystem Profile document for more details submitting
> +	   patches to the given subsystem. This is either an in-tree file,
> +	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
> +	   for details.

Considering each maintainer entry or driver may not have a subdirectory
under Documentation/ to put these under, would it be better to collect
them in one place, say Documentation/maintainer-entry-profiles/ ?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
