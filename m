Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3876CDD0B3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 22:56:47 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4978310FCB92D;
	Fri, 18 Oct 2019 13:58:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6D41710FCB92B
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:58:48 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 13:56:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,313,1566889200";
   d="scan'208";a="226670520"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga002.fm.intel.com with ESMTP; 18 Oct 2019 13:56:42 -0700
Date: Fri, 18 Oct 2019 13:56:42 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [ndctl patch 2/4] fix building of tags tables
Message-ID: <20191018205642.GC12760@iweiny-DESK2.sc.intel.com>
References: <20191018202302.8122-1-jmoyer@redhat.com>
 <20191018202302.8122-3-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191018202302.8122-3-jmoyer@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: ULHTXKM4XZ3LVTHHXJVLKP3MZXMED3GJ
X-Message-ID-Hash: ULHTXKM4XZ3LVTHHXJVLKP3MZXMED3GJ
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ULHTXKM4XZ3LVTHHXJVLKP3MZXMED3GJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 18, 2019 at 04:23:00PM -0400, Jeff Moyer wrote:
> Make <tags-variant> currently fails with:
> 
> make[1]: *** No rule to make target 'libndctl.h', needed by 'tags-am'.  Stop.
> 
> The path to libndctl.h is wrong in ndctl/lib/Makefile.am.  Fix it.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  ndctl/lib/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ndctl/lib/Makefile.am b/ndctl/lib/Makefile.am
> index fb75fda..e4eb006 100644
> --- a/ndctl/lib/Makefile.am
> +++ b/ndctl/lib/Makefile.am
> @@ -7,7 +7,7 @@ pkginclude_HEADERS = ../libndctl.h ../ndctl.h
>  lib_LTLIBRARIES = libndctl.la
>  
>  libndctl_la_SOURCES =\
> -	libndctl.h \
> +	../libndctl.h \
>  	private.h \
>  	../../util/log.c \
>  	../../util/log.h \
> -- 
> 2.19.1
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
