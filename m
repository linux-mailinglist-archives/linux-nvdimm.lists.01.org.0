Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06D52F3B59
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 21:04:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25D0B100EB852;
	Tue, 12 Jan 2021 12:04:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4A607100EB851
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 12:04:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g24so3727806edw.9
        for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 12:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdxtVLMD51rvFAUy0uouYzv2JNuR8PLKzsDJKh3c7Cc=;
        b=CgpDpWy/pkuZnqaYJDLuySEgBXiA4xKvWHC6DDiTgu764C6H2UCvCPUgHrlwGCzNgn
         fUPc1JLbqFUNBeCqrSEzGK8bJsHxrYcGVhvWQ61okYi8XBqIFrRUo/7g7pMkXeEDHvCa
         MyeA+dDYsLk+ftkMn3+9QPWX7bV5ijeBGChWSoAyKPKc9q42zWa9VlQF0vBw0z2xw9f9
         vWDACqEUBquj/+PzQCjr+uwpecPRHxBT/oDEcZt5AzrxJ4HfTHhe46p36xDJ/Bp+lxM0
         /5mQZHjY9h9MRqM4jAEgXFCkH91me6ItJ+CUCFgE+bTMLqtnIHXlIxnl6dDyQksB2VhH
         vsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdxtVLMD51rvFAUy0uouYzv2JNuR8PLKzsDJKh3c7Cc=;
        b=NKSN54CkVyh0hKyX/8O20AfU2eHt2MGtLzH8SRgJtxTl6jIrxFQvpWFwDAKzcCm50t
         JFGoq184tJcxBkqTq2s1oxBITq9ioYMEu+PmbUtR6prxkaWtrVeb3bt/QmwvlovoobdP
         hxje5dtK4qwysArIWC3OW+s+LW/dk1H+f5da2h0biVur1AgKbNILWraGqsBy5J39Dlne
         xsRqHTHF0lUpdoj87p3XxQkJytGki1w0F8692YpRmh5fXYSuwV7xCPWBKgvLmXufwUjd
         eXKn8t/VWNBa428r+1o4E7P57umMNzX4Mk68Lot0JrIzGvQciF67gaBLG8rSBIjzm+n6
         xQsA==
X-Gm-Message-State: AOAM532FUFMwkMTu0lRsBP4NVtQs6w4jqSSP54b1feWN5Ju8Ny4Ytrij
	1HizE0jZl5GeuyeQvys6vlYi0wTbpmfz7+Vksjkt+A==
X-Google-Smtp-Source: ABdhPJx9xG3m3PHJqgK6syqsFY+KpasjAjyzludTeiiipSmlClrjWTgEwzevdI3KyXO0/VPNMVZJDuulLjmGdX6Q/p0=
X-Received: by 2002:aa7:c2d8:: with SMTP id m24mr661543edp.300.1610481844483;
 Tue, 12 Jan 2021 12:04:04 -0800 (PST)
MIME-Version: 1.0
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044409809.1482714.11965583624142790079.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210112095345.GA12534@linux>
In-Reply-To: <20210112095345.GA12534@linux>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 12 Jan 2021 12:03:55 -0800
Message-ID: <CAPcyv4gb3t+QDqYXacgL-5npQ3ieL8XG9PvmgBSjZ5cdr_hF+A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: Fix page reference leak in soft_offline_page()
To: Oscar Salvador <osalvador@suse.de>
Message-ID-Hash: QAJIRMKNS6W3MYHFUR3CWOTE4XZBMD7A
X-Message-ID-Hash: QAJIRMKNS6W3MYHFUR3CWOTE4XZBMD7A
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>, stable <stable@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QAJIRMKNS6W3MYHFUR3CWOTE4XZBMD7A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 12, 2021 at 1:54 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Tue, Jan 12, 2021 at 01:34:58AM -0800, Dan Williams wrote:
> > The conversion to move pfn_to_online_page() internal to
> > soft_offline_page() missed that the get_user_pages() reference needs to
> > be dropped when pfn_to_online_page() fails.
>
> I would be more specific here wrt. get_user_pages (madvise).
> soft_offline_page gets called from more places besides madvise_*.

Sure.

>
> > When soft_offline_page() is handed a pfn_valid() &&
> > !pfn_to_online_page() pfn the kernel hangs at dax-device shutdown due to
> > a leaked reference.
> >
> > Fixes: feec24a6139d ("mm, soft-offline: convert parameter to pfn")
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> LGTM, thanks for catching this:
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
> A nit below.
>
> > ---
> >  mm/memory-failure.c |   20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 5a38e9eade94..78b173c7190c 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1885,6 +1885,12 @@ static int soft_offline_free_page(struct page *page)
> >       return rc;
> >  }
> >
> > +static void put_ref_page(struct page *page)
> > +{
> > +     if (page)
> > +             put_page(page);
> > +}
>
> I am not sure this warrants a function.
> I would probably go with "if (ref_page).." in the two corresponding places,
> but not feeling strong here.

I'll take another look, it felt cluttered...

>
> > +
> >  /**
> >   * soft_offline_page - Soft offline a page.
> >   * @pfn: pfn to soft-offline
> > @@ -1910,20 +1916,26 @@ static int soft_offline_free_page(struct page *page)
> >  int soft_offline_page(unsigned long pfn, int flags)
> >  {
> >       int ret;
> > -     struct page *page;
> >       bool try_again = true;
> > +     struct page *page, *ref_page = NULL;
> > +
> > +     WARN_ON_ONCE(!pfn_valid(pfn) && (flags & MF_COUNT_INCREASED));
>
> Did you see any scenario where this could happen? I understand that you are
> adding this because we will leak a reference in case pfn is not valid anymore.
>

I did not, more future proofing / documenting against refactoring that
fails to consider that case.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
