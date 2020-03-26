Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E33BC1946C3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Mar 2020 19:47:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6FB4A10FC3BA8;
	Thu, 26 Mar 2020 11:48:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2856010FC3BA7
	for <linux-nvdimm@lists.01.org>; Thu, 26 Mar 2020 11:48:10 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a43so8135257edf.6
        for <linux-nvdimm@lists.01.org>; Thu, 26 Mar 2020 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qcq4RNI6CNVIc/FHk1nBvRihOHJHOrgH9OoiMvUFCs=;
        b=p5WEILlf2qMrnIUD7fdkNam/lQ1yP+hBtdlEAWuNmT8CSdpLlvn7ghsUOBEovqOCt3
         eEduB1v5fuE9ssVWEGAVGe3yneBf+uof7U6LhqqlcTpwrm/EvXoaogCeogdDWVhzjNIT
         welSXQVuYgOKyHL3y3pW3gfRNTqqfzf6jVlnuBrX6qF6UnDC1IncZHO8UBxbBOTElMIO
         vYExAUvEAPtOuXhyrzXdz5qbli67vxZGdua6soPl1wuwhMFea47UsWvrdYbYxibWQsy1
         pLXAAf2IQ0LLSSwE1GqgDdBy98eJkOg0k8Av6VBj8mJqEWsUumoLYjFMA45D2on9ukk5
         LZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qcq4RNI6CNVIc/FHk1nBvRihOHJHOrgH9OoiMvUFCs=;
        b=KCnsi7Wgb0xOmrNzEEjB9viddqG3Z4tG35BsOPM+rCz1Rcn9KssaGWZ2+IazSYx1fZ
         XOb4wL44plQS7Z0cnwZGsYM4jcU6h27EoqVrY5mcvZaoUXR4rl3DJnvGdluRS9u/WGDO
         XJnSwqgYxEEw86wW8tSdNmiSS6JDD5amnje0NBZ8FVaB2BG+511QYf+c4V4xViCGL/7k
         GI6FYzQdvJxnfGrooxKcijhdgyW+jcBBP13VOD3lHix0xvWhL7vChPYnYybA3dmkrpBG
         3BuVXnoN3q/sYsbhlzW3ePLyOWknn4OtwHSXLaNwXnIxk4s3gReyCj9UtmJnaeXiAXAm
         Jxlg==
X-Gm-Message-State: ANhLgQ1kmbLnLiqsIvmcwCvRb2MVF0zvgo4S7eIxffsptNZGcMj0kjsF
	HSz3/p5qrFby1XrRkhJcVCZYK8pR02cI1qPANv+UPBK+6mw=
X-Google-Smtp-Source: ADFU+vt02gG7fOCceG4FlKaA7T9fcBxFteY0e/gGZSssHAof/MlQw5Oo3cpzCwPt4LYNmthiSWaGYvoKf3qe7OTuSKg=
X-Received: by 2002:a05:6402:1c8b:: with SMTP id cy11mr9907662edb.102.1585248438501;
 Thu, 26 Mar 2020 11:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <BN7PR11MB28495CCA929E46ADEB9B6B9296CF0@BN7PR11MB2849.namprd11.prod.outlook.com>
 <CAPcyv4h+uYSO3nYnOSOW-g=T_+puv6XzxvuN-GBca5Lua6jSdw@mail.gmail.com>
In-Reply-To: <CAPcyv4h+uYSO3nYnOSOW-g=T_+puv6XzxvuN-GBca5Lua6jSdw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 26 Mar 2020 11:47:07 -0700
Message-ID: <CAPcyv4gYQZTY2fND+Zxkb8TT-SFXpjkbVTQgXoSm8iuE65mx-A@mail.gmail.com>
Subject: Re: [ndctl PATCH] ndctl/README: Add a missing config setting
To: "Dorau, Lukasz" <lukasz.dorau@intel.com>
Message-ID-Hash: MXXX6EI6BPNDLU3WTMSIVKFKYPR5RUGM
X-Message-ID-Hash: MXXX6EI6BPNDLU3WTMSIVKFKYPR5RUGM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MXXX6EI6BPNDLU3WTMSIVKFKYPR5RUGM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 26, 2020 at 11:45 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Mar 26, 2020 at 2:25 AM Dorau, Lukasz <lukasz.dorau@intel.com> wrote:
> >
> > Add a missing config setting to README.md:
> > CONFIG_DEV_DAX_PMEM_COMPAT=m
>
> It's not required anymore as of:
>
> https://github.com/pmem/ndctl/commit/b7991dbc22f31d03a38f3ee2dca4446fb55279e3

...and this kernel patch:

https://lore.kernel.org/linux-nvdimm/20200123154720.12097-1-jack@suse.cz/
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
