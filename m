Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0F4EE93A
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Nov 2019 21:09:54 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B9487100EA540;
	Mon,  4 Nov 2019 12:12:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 74057100EA537
	for <linux-nvdimm@lists.01.org>; Mon,  4 Nov 2019 12:12:39 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 12:09:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400";
   d="scan'208";a="195567796"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga008.jf.intel.com with ESMTP; 04 Nov 2019 12:09:50 -0800
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX106.amr.corp.intel.com ([169.254.5.242]) with mapi id 14.03.0439.000;
 Mon, 4 Nov 2019 12:09:49 -0800
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH v2 2/2] ndctl/namespace: introduce
 ndctl_namespace_is_configuration_idle()
Thread-Topic: [ndctl PATCH v2 2/2] ndctl/namespace: introduce
 ndctl_namespace_is_configuration_idle()
Thread-Index: AQHVk0ugXTN7qAcsNU2o/2R3hL+jLqd79yIA
Date: Mon, 4 Nov 2019 20:09:48 +0000
Message-ID: <fc95ecd4191f6fb5eecf4cf16889055b048405a7.camel@intel.com>
References: <20191104200822.28959-1-vishal.l.verma@intel.com>
	 <20191104200822.28959-2-vishal.l.verma@intel.com>
In-Reply-To: <20191104200822.28959-2-vishal.l.verma@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <585356CA6C13654FB84E6D5A8EAE0A24@intel.com>
MIME-Version: 1.0
Message-ID-Hash: ZKFDSJQFW4FAUC27YVICZHIOCQ7LEC4A
X-Message-ID-Hash: ZKFDSJQFW4FAUC27YVICZHIOCQ7LEC4A
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZKFDSJQFW4FAUC27YVICZHIOCQ7LEC4A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Mon, 2019-11-04 at 13:08 -0700, Vishal Verma wrote:
> 
> diff --git a/util/sysfs.c b/util/sysfs.c
> index 9f7bc1f..81cd055 100644
> --- a/util/sysfs.c
> +++ b/util/sysfs.c
> @@ -20,6 +20,7 @@
>  #include <ctype.h>
>  #include <fcntl.h>
>  #include <dirent.h>
> +#include <stdbool.h>

These are stray lines from the previous version, I'll resend removing
these. Sorry for the noise.

>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <sys/ioctl.h>
> diff --git a/util/sysfs.h b/util/sysfs.h
> index fb169c6..b2d28f1 100644
> --- a/util/sysfs.h
> +++ b/util/sysfs.h
> @@ -14,6 +14,7 @@
>  #define __UTIL_SYSFS_H__
>  
>  #include <string.h>
> +#include <stdbool.h>
>  
>  typedef void *(*add_dev_fn)(void *parent, int id, const char *dev_path);
>  

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
