Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7EC7FF53
	for <lists+linux-nvdimm@lfdr.de>; Fri,  2 Aug 2019 19:15:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C7B62130C4BB;
	Fri,  2 Aug 2019 10:17:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9B04B21306CC3
 for <linux-nvdimm@lists.01.org>; Fri,  2 Aug 2019 10:17:54 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Aug 2019 10:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; d="scan'208";a="373016915"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2019 10:15:22 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 2 Aug 2019 10:15:22 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.180]) by
 fmsmsx163.amr.corp.intel.com ([169.254.6.210]) with mapi id 14.03.0439.000;
 Fri, 2 Aug 2019 10:15:22 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "kilobyte@angband.pl" <kilobyte@angband.pl>
Subject: Re: [PATCH] daxctl: link against libndctl, in case its use doesn't
 get pruned
Thread-Topic: [PATCH] daxctl: link against libndctl, in case its use doesn't
 get pruned
Thread-Index: AQHVSASqcWQ+7jn/yEeB1TN6952yd6bokQgA
Date: Fri, 2 Aug 2019 17:15:21 +0000
Message-ID: <47f7555596eae0f7daef0d6a0a9ce0bae96f6af4.camel@intel.com>
References: <20190801010044.56927-1-kilobyte@angband.pl>
In-Reply-To: <20190801010044.56927-1-kilobyte@angband.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <1ABDC69972287348A26591A6025BA3A6@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, 2019-08-01 at 03:00 +0200, Adam Borowski wrote:
> util/json.c uses libndctl symbols, and is included by daxctl.  These
> functions should then get pruned as unused, but on some platforms the
> toolchain fails to do so.
> 
> These platforms are ia64, hppa and 32-bit powerpc.  It's generally a
> waste of our time to build ndctl there, but as the lack of a
> build-dependency requires annoying workarounds higher in the stack,
> this has been requested in https://bugs.debian.org/914348 -- and is
> trivially fixable on the ndctl side.
> 
> Thanks to -Wl,--as-needed there's no harm to architectures where the
> pruning works, thus let's not bother with detection.
> 
> As daxctl and libdaxctl are separate, there's no circular dependency.
> 
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  daxctl/Makefile.am | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Hi Adam,

Thanks for the report and the patch - however, historically, we've
avoided linking from daxctl to libndctl.

I think we can still avoid this by moving the libndctl users in
util/json.c and util/filter.c into respective ndctl/util/ files.

The same goes for libdaxctl users in those files - they move into
daxctl/util/

I think that would be a cleaner approach, and I can take a shot at
making the split next week, however we're close to a v66 release, and it
will have to be after that happens.

Perhaps the debian package can temporarily carry your patch for the
archs that fail?

Thanks,
	-Vishal

> 
> diff --git a/daxctl/Makefile.am b/daxctl/Makefile.am
> index 94f73f9..a5487d6 100644
> --- a/daxctl/Makefile.am
> +++ b/daxctl/Makefile.am
> @@ -21,4 +21,5 @@ daxctl_LDADD =\
>  	lib/libdaxctl.la \
>  	../libutil.a \
>  	$(UUID_LIBS) \
> -	$(JSON_LIBS)
> +	$(JSON_LIBS) \
> +	../ndctl/lib/libndctl.la

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
