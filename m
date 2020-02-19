Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9B81639B6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 02:58:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A384C10FC341C;
	Tue, 18 Feb 2020 17:59:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com; envelope-from=jencce.kernel@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B081C10FC340D
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 17:59:20 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 185so11665855pfv.3
        for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 17:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q/nY1Mf51kH8KT0v62tDiqkFUg4146cYnGwpmJwHyYo=;
        b=ipHlH/AlxVQ/IulE7p5AjzOFHiVR1RBrVYYtMyUoV1UQoG/6dZkSxq2PGqL2fniBgm
         p2Y3huDQAm29/M/8lvlIqo28KOk7mjIsnca2skalBXejbHNR1Lrgos+j48iiEPvhqLDw
         N6lchqBHGjjVN/a0DsS4yGeBI/RdwNASQm1aspA3tBfW0yDxxMFQxIwSs8xp7NcmY1D/
         lCOit0ez4+qPD2E7FNkgD5GxN4hi4xESTM/cOe6e6LQV233A0JernCGhcyycJGO0ApCc
         c7wG+rJ1X+e7UIgAO7ZZ+RZZExBkp5m2WFgdAws1sbupJEUXH/dcteNZKPo27wy5uELj
         Mwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/nY1Mf51kH8KT0v62tDiqkFUg4146cYnGwpmJwHyYo=;
        b=AnbvXgkNarbvPT/oI02pLlQyuDn6scyp06qSrUC2vI56IQ/tbkE9BLJZoN4l2cRe4A
         gfe76Uou2rMZDTm+CNMz1HzR2K9yRoU+O9fvJA6Yke/dBQK34Uc4jgn08pwdPHXWXjam
         lwVU+OJa95nTRNr51eOYHt4ESYfbD7IT4A/hl3TLoM+AG+I19/YD8coMafYC32dHbMr3
         4iEPCVByhaaXN83y0p2ay4KZVPklsaLy0P2P38bPJDpxCfVX1DEZFwKfHum8IPiRVC0z
         LwvwLu40yBpBNA8+IHCGN7WiGt31vfHji1/Nl3FEyGoA02zKymA54TdHg7TvQ0F1tWGt
         AI/w==
X-Gm-Message-State: APjAAAWVwLwIRcucmR+9jUo/Y738lEl6zE4Ocxx1G0ZJm/hD7sjCF/gd
	REiwgfL41gJF30ex0TDiM4g=
X-Google-Smtp-Source: APXvYqzFJQ7t+g8cJNhe0uBXgIH3F++H+a+3qLANXSylYjhWNApUO0k8Gw5fe0DVzEJDNArl3M7gpg==
X-Received: by 2002:aa7:9629:: with SMTP id r9mr24801465pfg.51.1582077507872;
        Tue, 18 Feb 2020 17:58:27 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e2sm206430pjs.25.2020.02.18.17.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 17:58:27 -0800 (PST)
Date: Wed, 19 Feb 2020 09:58:19 +0800
From: Murphy Zhou <jencce.kernel@gmail.com>
To: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] mm: get rid of WARN if failed to cow user pages
Message-ID: <20200219015819.otdnknxpyo52txy7@xzhoux.usersys.redhat.com>
References: <20191225054227.gii6ctjkuddjnprs@xzhoux.usersys.redhat.com>
 <CAPcyv4hMPh0C+_OV+vuiYQikb8ZvRanna4vXfKN=10yrAyCjDA@mail.gmail.com>
 <x49imk3bo1h.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <x49imk3bo1h.fsf@segfault.boston.devel.redhat.com>
Message-ID-Hash: M5NRRIRN63XXQOGYUTFFNXNJKFQ66KDY
X-Message-ID-Hash: M5NRRIRN63XXQOGYUTFFNXNJKFQ66KDY
X-MailFrom: jencce.kernel@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Jia He <justin.he@arm.com>, Linux MM <linux-mm@kvack.org>, "Shutemov, Kirill" <kirill.shutemov@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/M5NRRIRN63XXQOGYUTFFNXNJKFQ66KDY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 18, 2020 at 04:09:30PM -0500, Jeff Moyer wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > [ drop Ross, add Kirill, linux-mm, and lkml ]
> >
> > On Tue, Dec 24, 2019 at 9:42 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
> >>
> >> By running xfstests with fsdax enabled, generic/437 always hits this
> >> warning[1] since this commit:
> >>
> >> commit 83d116c53058d505ddef051e90ab27f57015b025
> >> Author: Jia He <justin.he@arm.com>
> >> Date:   Fri Oct 11 22:09:39 2019 +0800
> >>
> >>     mm: fix double page fault on arm64 if PTE_AF is cleared
> >>
> >> Looking at the test program[2] generic/437 uses, it's pretty easy
> >> to hit this warning. Remove this WARN as it seems not necessary.
> >
> > This is not sufficient justification. Does this same test fail without
> > DAX? If not, why not? At a minimum you need to explain why this is not
> > indicating a problem.
> 
> I ran into this, too, and Kirill has posted a patch[1] to fix the issue.
> Note that it's a potential data corrupter, so just removing the warning
> is NOT the right approach.  :)

Agree :) Thanks!

> 
> -Jeff
> 
> [1] https://lore.kernel.org/linux-mm/20200218154151.13349-1-kirill.shutemov@linux.intel.com/T/#u
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
