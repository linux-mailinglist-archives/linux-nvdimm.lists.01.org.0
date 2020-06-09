Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478E1F2EEB
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Jun 2020 02:46:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A49B100AA7B6;
	Mon,  8 Jun 2020 17:46:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0CE1C100AA7B4
	for <linux-nvdimm@lists.01.org>; Mon,  8 Jun 2020 17:46:54 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w7so14957595edt.1
        for <linux-nvdimm@lists.01.org>; Mon, 08 Jun 2020 17:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zCH4n2iYndxCImQUVO1t9gw8KAnucClc8TKaXcz6VE=;
        b=Fq2WqHVeE81Nk6/Y0DGUX0PV2/hDVPJDGUYPIo3pxtCcQjIa6R//iPZadETarfnAzT
         tlwhSjrEN/2Mjan9gz24mXSQu9dOYhzwWdqc2Q0xT715EekdH3eg0fxIvFgM3eRLWgLN
         78TZPoqHOfMK62A9ZJhEzlwmtqtbesyOCnOYd4H/O4Ti5pd09CcSkCIUY1/sj0tPY8Xc
         3Wc13HH5AEC14rFecdON9Rt3tBXKBzr9b6or5LhepX6BXw5CLcEfmLZAwLOtuGpiRW//
         YK+q6h65xUPqiwCvAKne4a3em0MZjfum74LdoxdMkfCZkPYVK/UwQyfbfpME0PiWBIdQ
         h2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zCH4n2iYndxCImQUVO1t9gw8KAnucClc8TKaXcz6VE=;
        b=tbuajuYQsUu0sBr/JqOoN19GfoI6kPbE0Jsq+Y6+gt3Brf4k3DX+AKRqLJJOQLGZno
         yqZ1cumycjTjWIpi50p14KbXsTvjpMThnaYkMiJ2headlISHj7gZHgaK4LIftMA6t9Vu
         FePc41NrqVxPAlEAKre2Ym5qyUR04in+FhrEZIZDKVTlROQHtviLINY2dKkcck9K5ugI
         MjCR3cdEM5R/rFvcMB5KpOrSQf55kxleLPgpb5cyAl4diy0b0n7UjRpnQ24N7MbFACx3
         dfwDxHrp44pPViShN3nKGbyfEx9cFZ8tMLFEkHTk499MR5BoKGBkNIQ6bOVxtDqFJ2MT
         ZecA==
X-Gm-Message-State: AOAM531BSBRwtJv18ehTKG4VS5y/pb6/p5fw5ax4YBrnLDA8BCwgYt3E
	DYyOPFEnsOMXg+9bz+Pc1W+Fa7Q8Wz4ZVPXnWhivQQ==
X-Google-Smtp-Source: ABdhPJyPiL73dzr0k16R7WSQX3Z3pfrFMXEsfHYxl183PZK4kpvT14ODaxWMSzzuq7exBiIPN3x17ifOOa1H+rWsmBY=
X-Received: by 2002:a50:eb0c:: with SMTP id y12mr23805262edp.165.1591663613143;
 Mon, 08 Jun 2020 17:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200607131339.476036-6-vaibhav@linux.ibm.com> <202006090059.o4CE5D9b%lkp@intel.com>
In-Reply-To: <202006090059.o4CE5D9b%lkp@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 8 Jun 2020 17:46:42 -0700
Message-ID: <CAPcyv4iQo_xgRGPx_j+RPzgWGZaigGRbc_kRzKEFePfVHenx5g@mail.gmail.com>
Subject: Re: [PATCH v11 5/6] ndctl/papr_scm,uapi: Add support for PAPR nvdimm
 specific methods
To: kernel test robot <lkp@intel.com>
Message-ID-Hash: HACXWNTJWNCYGIFZFZSONPOE42M4EWXL
X-Message-ID-Hash: HACXWNTJWNCYGIFZFZSONPOE42M4EWXL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org, clang-built-linux <clang-built-linux@googlegroups.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HACXWNTJWNCYGIFZFZSONPOE42M4EWXL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 8, 2020 at 5:16 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Vaibhav,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on powerpc/next]
> [also build test WARNING on linus/master v5.7 next-20200605]
> [cannot apply to linux-nvdimm/libnvdimm-for-next scottwood/next]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Vaibhav-Jain/powerpc-papr_scm-Add-support-for-reporting-nvdimm-health/20200607-211653
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-randconfig-r016-20200607 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project e429cffd4f228f70c1d9df0e5d77c08590dd9766)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> In file included from <built-in>:1:
> >> ./usr/include/asm/papr_pdsm.h:69:20: warning: field 'hdr' with variable sized type 'struct nd_cmd_pkg' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
> struct nd_cmd_pkg hdr;  /* Package header containing sub-cmd */

Hi Vaibhav,

This looks like it's going to need another round to get this fixed. I
don't think 'struct nd_pdsm_cmd_pkg' should embed a definition of
'struct nd_cmd_pkg'. An instance of 'struct nd_cmd_pkg' carries a
payload that is the 'pdsm' specifics. As the code has it now it's
defined as a superset of 'struct nd_cmd_pkg' and the compiler warning
is pointing out a real 'struct' organization problem.

Given the soak time needed in -next after the code is finalized this
there's no time to do another round of updates and still make the v5.8
merge window.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
