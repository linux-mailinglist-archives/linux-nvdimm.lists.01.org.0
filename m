Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F78CDCF2E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 21:15:52 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7157510FCB398;
	Fri, 18 Oct 2019 12:17:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C828010FCB397
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 12:17:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 41so5857865oti.12
        for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 12:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1h8ZdYbizn3ObFBMEt75+VFVHEgK+aRf5uPhoWtkSl4=;
        b=gnUegOxbJ3gNs9k8Zu4DB8Bu0xl0o/epseBPbaQpYV88grp5DWBmU0T6RWcTCh+PIQ
         N/oXoMrjsQoAJE3nSi/y+Cs693xWIOs3WD+B4EbkT5RQtiuuyqwISMrjp8iGUmfH6wvc
         9o36Ll+PheTjiOGM+v1mfA5xVIrtWSl+hr1gV/Zmg1BUI1HWnY5uiN4Q4dyWugrUcKkG
         HRvDQOKDTfKTfn0IhMH65G9R1Vn8PpfiOunINqpr8MjpgKTAFsqmqTb8+V7WbzBcP4wR
         j9hg2mNim3K/ZbS/zHZXqNcUnVZ3u+sfb/+/FU3wGO/pXIn9OUeZxuDq8GtABI4RU2LD
         LpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1h8ZdYbizn3ObFBMEt75+VFVHEgK+aRf5uPhoWtkSl4=;
        b=Z2khZZXxAEBHfDzXcGkZjaP2VIFk/KwTlh2e/PL9C51vmv0AmL2pJbkgFvZ0OAanex
         xm5TmOcfdGC2IMu5WngL35y1M+96mP5sPoxP31VPw4huoY9YtQ5cAIiIEAJ2p25EIpSb
         vEUvs57jW5nbvQjvwllXWJDfGVCZHg4yYjLmpwjqf+SoSOV3D2LC9oYU6dnMwUIoMPJm
         9QTANjEcRTMR8PGFDVDgD2lqYLnxukgRofU9NszGKZw/ExASuZ5n7phDN7Oy1Zos3F5h
         4KLmUXggf2f6e2BEeDy8cjJjgXB5eiY/zM9fff6/52cyXH6CN8v3kovoOugCC6fmznVK
         FHdg==
X-Gm-Message-State: APjAAAVKtTmN2VtzcYdhZmQGTBLg9OOJ8z0RdHs6o0lWPHPJFtKgNEn1
	St+q+V7smJW3+sWKNnYsp0JQ3J7OrTisxz2fyBMZpg==
X-Google-Smtp-Source: APXvYqzyawt2DNExTfuF3FgHs4R6l1Y1xLX9qhjHt369P84/bHApiD63KP8F1GmHmCJk2HH74Fp/U2Mdz+7IbE3ynl0=
X-Received: by 2002:a9d:5f11:: with SMTP id f17mr1585651oti.207.1571426147046;
 Fri, 18 Oct 2019 12:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191002234925.9190-1-vishal.l.verma@intel.com> <20191002234925.9190-6-vishal.l.verma@intel.com>
In-Reply-To: <20191002234925.9190-6-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Oct 2019 12:15:35 -0700
Message-ID: <CAPcyv4hLfO=+SfAM7Ww6YVF7K3FgjTxks7bkx+KkmKbwS0Uczg@mail.gmail.com>
Subject: Re: [ndctl PATCH 05/10] libdaxctl: allow memblock_in_dev() to return
 an error
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: 5Z3L6VIA3NKOAVMKXTVSA4LSLPYLQQF6
X-Message-ID-Hash: 5Z3L6VIA3NKOAVMKXTVSA4LSLPYLQQF6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ben Olson <ben.olson@intel.com>, Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5Z3L6VIA3NKOAVMKXTVSA4LSLPYLQQF6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2019 at 4:49 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> With the MEM_FIND_ZONE operation, and the expectation that it will be
> called from 'daxctl list' listings, it is possible that memblock_in_dev()
> gets called without sufficient privileges. If this happens, currently,
> the above simply returns a 'false'. This was acceptable when the only
> operations were onlining/offlining (as there would be an actual failure
> later). However, it is not acceptable in the MEM_FIND_ZONE case, as it
> could yeild a different answer based on the privilege level.
>
> Change memblock_in_dev() to return an 'int' instead of a 'bool' so that
> error cases can be distinguished from actual address range test.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
