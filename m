Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C68F19B6EF
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 22:27:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29A5A10FC4035;
	Wed,  1 Apr 2020 13:28:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9F1A610FC4033
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 13:28:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cf14so1423482edb.13
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 13:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ox3otBw8CzCvAty3EpckqUjW2/oZzIrj4z0gJgITkh8=;
        b=sQuNaukoLTYPKuSCOZWDal0NVhFHo2FQ1CmrMenvvhrri0xPkNrgQjkJcS1+O304jX
         G1LL/dvPZIIr5S9WQMK/YzWuBdT05hnu8M2sVpzIve49oA8uvXfH3d99ZokG/NhXws72
         wmFZ2tu2j2+0e7hD39WL0MxFiP1l0JGtXpUDxN8szy2nhjCLK2S7TgZrjq4FfFPh1Yvx
         +MdXV7ahHwxBQTe7fjTbXXXHhUTv0/xGRNa8wzR7wn7HAVNFCmWFhr2x85j8eb8qnyz6
         WXKxqKPC0Ebv8XtBB+cwMF+QyoYWOsaxqiAQsei59ulMxlQvzjoT+Riz/P477b/2B2k7
         YmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ox3otBw8CzCvAty3EpckqUjW2/oZzIrj4z0gJgITkh8=;
        b=mmQx+/v/lnHLwnPlrnoHXwPZh4LnM8Ks67GRuRhKRB2ukvdwHTcDnYT9O+ZAWHMHfx
         ZWWXc1iwijrABNndH8xAve1z/uOWJgjxzrv8xRIQU2ILiuenW7pC9WrbN58vFrcc8deL
         z43T6aqf0ff8x4Mz/ruwquFQEBSYJOuGNsVRI4JPAR7D9kRV7b1eLMTLJOSRhDSgKlH/
         2fJQoyRvhv1OPGPfxgv+B7sKulG36Ze4ca7FgUS3vVTztFrCmXnJDyhM/oeM46faGYcn
         DJeZgNw5eEGyaFZcnFtwCTq2uPwDjZ2CqKd2efmIUc19UwJjObGvd6YQaU8mEP6mf1VC
         Xrdg==
X-Gm-Message-State: ANhLgQ2Y+1R4LqAz8iCwhVdUR3paBYoMwHPURvTQJ6XBWKd5KqAr9F6H
	8ktrFVNBs2hpjNkXRtdtxSLMte7Cg5DDTLNzKa4crw==
X-Google-Smtp-Source: ADFU+vuuCiWk8AFivXDQPqBgDNLDGhDO6sjqg2/h0Q5ehu4Z/Qb1gPEAD/3R4NV/CE3+xOjAXK/2PN8nmS9Qu76SchY=
X-Received: by 2002:a17:906:dbd4:: with SMTP id yc20mr21851655ejb.335.1585772854886;
 Wed, 01 Apr 2020 13:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-13-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-13-alastair@d-silva.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 13:27:22 -0700
Message-ID: <CAPcyv4hBSa_62siaaOR+PG7cEohTp-xnxZ576aJO0BDofJEN=A@mail.gmail.com>
Subject: Re: [PATCH v4 12/25] nvdimm/ocxl: Add register addresses & status
 values to the header
To: "Alastair D'Silva" <alastair@d-silva.org>
Message-ID-Hash: CFJXU2J63QE4IPWCSBCL5SJEDSFP2MDW
X-Message-ID-Hash: CFJXU2J63QE4IPWCSBCL5SJEDSFP2MDW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CFJXU2J63QE4IPWCSBCL5SJEDSFP2MDW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 10:53 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> These values have been taken from the device specifications.

Link to specification?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
