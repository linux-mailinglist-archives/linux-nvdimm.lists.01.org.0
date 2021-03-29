Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B66434DC5F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Mar 2021 01:24:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BED06100EBB97;
	Mon, 29 Mar 2021 16:24:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7F78E100EBB8F
	for <linux-nvdimm@lists.01.org>; Mon, 29 Mar 2021 16:24:32 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u9so21950570ejj.7
        for <linux-nvdimm@lists.01.org>; Mon, 29 Mar 2021 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XF4To2Y7zgtF2QAVYiT7BBwCvauONTod77W3/2lXGW8=;
        b=Vsx9drBV7ccArQSqmDPqC+lTIb/A77ziMCx5iPDxYzAHz5bdXrgSzOciH2G+olKEzH
         JH+aiwgu7Hdc7Js/CFjZeYUNpwx0+EJ4WO1eE2x1fsFGzMOLBuWvUcrIpPIC/BzArvmG
         SoSbsrr1a84pxS45T+LCHCPrZ4YT1EgHckSDx8IT4d9M/APuB7pnuC8BPH8hgLx1YKnX
         8mmS8RFApDIqRbHB5XlYzw5cDHp5hIR3/bxLlGci8wVKnPeuvAPgpq7rHtbNCE/aUyzk
         mUztjRYlXDhIeGmczBxkjzDSdIyVqVIUQsrF4xS7Qy5pZtzbw/waLYA0DM0/VC+iNd0Y
         Zt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XF4To2Y7zgtF2QAVYiT7BBwCvauONTod77W3/2lXGW8=;
        b=OF6RbvslAQBHGalnjg+DrXCup6HgtvLpfQufSjuE/lcFgSuEZMJ/lAxNuYaL8qeEEB
         dZv2PzeThgpDp+11X4U2D6h8vFahx2gVQD45YhlIWiIy2WQgIqXbKLXbjGLRnbZ0y+TS
         6ax2y3zH+m8+/FSXgzmHd0GveihNS4QS0uTQ0neCihG4RPKiBzMJLoRPqwvbN9kLUWVX
         WwwO6rb1CzH4XboRfCiYhaJk9DCAyvjDlax8E9KlbeJM6hV5D2kNgEtHxl5X06o+Bmt6
         tpgzCbtj7Wn7Uz+WS2rzI7I0NOLOOsGsEEkve9Pwq1LkwS4qTFUlksBu4ltZ9Q5K71cd
         kbkQ==
X-Gm-Message-State: AOAM5329MzgsxSbtoO7iCWvHLw3M0UuMfGXhxBXnw6m+HLYQwMc8FawR
	5F43l8Tb/a0vOJRn+3JPQvsgbmwUQt5H5fvCVklDEQ==
X-Google-Smtp-Source: ABdhPJzf7VrSfLTELhnrW6mwobm/98+lZofBo3iswIzq94rBp2GFqTi32x/lL+dUXpEu98/zFDAR5BEkXvlHn9IcDz4=
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr29769425ejb.264.1617060270344;
 Mon, 29 Mar 2021 16:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
 <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com> <CAPcyv4g8=kGoQiY14CDEZryb-7T1_tePnC_-21w-wTfA7fQcDg@mail.gmail.com>
 <20210325143419.GK2710221@ziepe.ca>
In-Reply-To: <20210325143419.GK2710221@ziepe.ca>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 29 Mar 2021 16:24:19 -0700
Message-ID: <CAPcyv4hHHFD4cvdRmajWgYbXU5-o-jF-o6D5ud-rg4dWNqt5Ag@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
To: Jason Gunthorpe <jgg@ziepe.ca>
Message-ID-Hash: ALWSP4RA4RGS7AJ2L76Q3UC2AZ437JEZ
X-Message-ID-Hash: ALWSP4RA4RGS7AJ2L76Q3UC2AZ437JEZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, Christoph Hellwig <hch@lst.de>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, david <david@fromorbit.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ALWSP4RA4RGS7AJ2L76Q3UC2AZ437JEZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 25, 2021 at 7:34 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Mar 18, 2021 at 10:03:06AM -0700, Dan Williams wrote:
> > Yes. I still need to answer the question of whether mapping
> > invalidation triggers longterm pin holders to relinquish their hold,
> > but that's a problem regardless of whether gup-fast is supported or
> > not.
>
> It does not, GUP users do not interact with addres_space or mmu
> notifiers
>

Ok, but the SIGKILL from the memory_failure() will drop the pin?

Can memory_failure() find the right processes to kill if the memory
registration has been passed by SCM_RIGHTS?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
