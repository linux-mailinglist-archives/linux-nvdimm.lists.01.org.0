Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E1C22D656
	for <lists+linux-nvdimm@lfdr.de>; Sat, 25 Jul 2020 11:12:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 77AFA125C92F0;
	Sat, 25 Jul 2020 02:12:51 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=sakari.ailus@linux.intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 73DDB125C2237
	for <linux-nvdimm@lists.01.org>; Sat, 25 Jul 2020 02:12:49 -0700 (PDT)
IronPort-SDR: yKXNGVlskpkbVupgcCpikpZ54TnPvc/sk1PEHfW7hBkZmsEQmDUUdHiXnOdyVngzAL9Dy8fdeS
 csJ3dzBdB6Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130900612"
X-IronPort-AV: E=Sophos;i="5.75,394,1589266800";
   d="scan'208";a="130900612"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2020 02:12:48 -0700
IronPort-SDR: gOzP//zZ6j2kiA9GjZd7m2HA8PgWDRWUZ/wYEfKzGLbtNZWszauNz3kZXmqiwzogVMHf0v5fc9
 yrymHi8gVaqQ==
X-IronPort-AV: E=Sophos;i="5.75,394,1589266800";
   d="scan'208";a="329154913"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2020 02:12:46 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
	id 2A5112079D; Sat, 25 Jul 2020 12:12:44 +0300 (EEST)
Date: Sat, 25 Jul 2020 12:12:44 +0300
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: Re: [PATCH] ACPI: Replace HTTP links with HTTPS ones
Message-ID: <20200725091244.GE16711@paasikivi.fi.intel.com>
References: <20200717182436.75214-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717182436.75214-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: MOFCVGVWWGUXLJ2FWKN6MUHD6ODPJTSD
X-Message-ID-Hash: MOFCVGVWWGUXLJ2FWKN6MUHD6ODPJTSD
X-MailFrom: sakari.ailus@linux.intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MOFCVGVWWGUXLJ2FWKN6MUHD6ODPJTSD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Alexander,

Thanks for the patch.

On Fri, Jul 17, 2020 at 08:24:36PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
> 
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  .../firmware-guide/acpi/DSD-properties-rules.rst       |  4 ++--
>  .../firmware-guide/acpi/dsd/data-node-references.rst   |  4 ++--
>  Documentation/firmware-guide/acpi/dsd/graph.rst        | 10 +++++-----
>  Documentation/firmware-guide/acpi/dsd/leds.rst         |  6 +++---

For ACPI _DSD and data-node-references:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
