Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5D9347DCA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Mar 2021 17:37:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 81C18100EB322;
	Wed, 24 Mar 2021 09:37:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6FA0D100EB859
	for <linux-nvdimm@lists.01.org>; Wed, 24 Mar 2021 09:37:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o19so28355971edc.3
        for <linux-nvdimm@lists.01.org>; Wed, 24 Mar 2021 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F78F4/Kq+ndIvAG3q41JlNnbimm1afFKY1uPrkgKEKE=;
        b=CsDx6xAl1VtYRX8X8nlGVP72pS+Njf2eRG9UeLEcNYw/0GG+u51E8oRfnZj6k3/sNg
         aRLLF/mmJCW58czyShqa6WkR7qJxQwuiCLVxyrBpZ+TAPagZGTpDfa7+zl7Dur1DKlk4
         B1AAACFL6xsj3ekCmh1gjol0o/QSp3xiwcbei6jwyZhVy3/cDah43fcg8J30O9ZE/PgR
         mQCXAHzOBzR2wsLGgkCG9GE3xk75u+tWfyPHSZJGznQsHqijxofg2L4Q1jPv+MKqUCHE
         RQjr95+R6I9EMKEYtmdWrRAb9fTP8P6XndMLkaPTVlg8oBOUifEZ/RsV84+JGEN92W79
         y2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F78F4/Kq+ndIvAG3q41JlNnbimm1afFKY1uPrkgKEKE=;
        b=Bhtyq/UtGho2JEcDALtXANmdhixSp+/76ZFrR+TABZZkWm/V2UBHvVtL7Vwo2G2NbO
         nuEP7qAmfCRinLN39KJS5Q2ifZsOr63tkvL0Y9WSxTisgjLYcOA/G+r7pt7htdU8MmHa
         +NtwLljmYGt+W7b0HOEdUqjZyx/X+OIQMFkG/xf+fa0BY0ddlsKNP+q3afV9YYrzQ2np
         RdBMKSdS18t2UEipmK23esyqaXZs/ERmTa4/k08wg+N8tB7w+iuGf/YLe2uQBA5tiljp
         pIXIz5AvGPdQvsb4oEDTgZodXPk/7Tvo020o9ObMtb90c6YQkk1ywiiF+ejALouEloG+
         JUtQ==
X-Gm-Message-State: AOAM532MjXC0iH2fdm6jueXbQhswhwgQgOa2bPnuUfScKMHEvVzPnE9E
	woz6GUijaGHTCTwweia4nMB+26Yn3w6YUGES09XOig==
X-Google-Smtp-Source: ABdhPJy0i6T+2AM1FhaOe2x1NOEA+VihVGm8Q0AyYdTDg9DUntxFo3NhisOlYTqdDwwzXOKs7/wWOwG2TBuN7zwJqD8=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr4548882edc.210.1616603832460;
 Wed, 24 Mar 2021 09:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com> <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
 <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com>
 <OSBPR01MB2920E46CBE4816CDF711E004F46F9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <OSBPR01MB29208779955B49F84D857F80F4689@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4jhUU3NVD8HLZnJzir+SugB6LnnrgJZ-jP45BZrbJ1dJQ@mail.gmail.com> <20210324074751.GA1630@lst.de>
In-Reply-To: <20210324074751.GA1630@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 24 Mar 2021 09:37:01 -0700
Message-ID: <CAPcyv4hOrYCW=wjkxkCP+JbyD+A_Po0rW-61qQWAOm3zp_eyUQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: RHWOSYCKEM46HFZMRUJJST62FISLYK7L
X-Message-ID-Hash: RHWOSYCKEM46HFZMRUJJST62FISLYK7L
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, device-mapper development <dm-devel@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, david <david@fromorbit.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Goldwyn Rodrigues <rgoldwyn@suse.de>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RHWOSYCKEM46HFZMRUJJST62FISLYK7L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 24, 2021 at 12:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Mar 23, 2021 at 07:19:28PM -0700, Dan Williams wrote:
> > So I think the path forward is:
> >
> > - teach memory_failure() to allow for ranged failures
> >
> > - let interested drivers register for memory failure events via a
> > blocking_notifier_head
>
> Eww.  As I said I think the right way is that the file system (or
> other consumer) can register a set of callbacks for opening the device.

How does that solve the problem of the driver being notified of all
pfn failure events? Today pmem only finds out about the ones that are
notified via native x86 machine check error handling via a notifier
(yes "firmware-first" error handling fails to do the right thing for
the pmem driver), or the ones that are eventually reported via address
range scrub, but only for the nvdimms that implement range scrubbing.
memory_failure() seems a reasonable catch all point to route pfn
failure events, in an arch independent way, to interested drivers.

I'm fine swapping out dax_device blocking_notiier chains for your
proposal, but that does not address all the proposed reworks in my
list which are:

- delete "drivers/acpi/nfit/mce.c"

- teach memory_failure() to be able to communicate range failure

- enable memory_failure() to defer to a filesystem that can say
"critical metadata is impacted, no point in trying to do file-by-file
isolation, bring the whole fs down".

> I have a series I need to finish and send out to do that for block
> devices.  We probably also need the concept of a holder for the dax
> device to make it work nicely, as otherwise we're going to have a bit
> of a mess.

Ok, I'll take a look at adding a holder.

>
> > This obviously does not solve Dave's desire to get this type of error
> > reporting on block_devices, but I think there's nothing stopping a
> > parallel notifier chain from being created for block-devices, but
> > that's orthogonal to requirements and capabilities provided by
> > dax-devices.
>
> FYI, my series could easily accomodate that if we ever get a block
> driver that actually could report such errors.

Sure, whatever we land for a dax_device could easily be adopted for a
block device.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
