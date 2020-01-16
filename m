Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088C313EE72
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jan 2020 19:09:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D772A10096CA7;
	Thu, 16 Jan 2020 10:12:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EA64310096CA6
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jan 2020 10:12:52 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 59so20204157otp.12
        for <linux-nvdimm@lists.01.org>; Thu, 16 Jan 2020 10:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQb8Uq0IKx193QyLS3C+yGAjzOMy3a3CukknBRN2elo=;
        b=Z9dKYGG/It3ZDq626KVAn3UYMJ8w5rR7FNp1xgY+lJV2JdQ8DWHIetf1F8KloLda3X
         39gAmzG6xzkqr5D4Ak+0h08VxlZHpS0TnHAHHZwNZrxSD9H0o70ll3pjpzqbXTbh1DKL
         DNBT464rgyw5mNlpF54auwQ7W0YShGDSgsOZLiQe9UuUK/EI3rXInwadnnG1lGK7QCU1
         3w5gr6gsDviIi8iAJ4m/+JCGUJ3agwdBGY3e7V1tUCcAsasgKFwzh4MHrwHdLzXIgLAk
         x0PHbDzD2veOuVMZQjGO+cEu0iHunQLVEGPuaT782qMLmcgX5LnyP/rsd3PiYSGCcLoS
         c59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQb8Uq0IKx193QyLS3C+yGAjzOMy3a3CukknBRN2elo=;
        b=D2r3KST3VgcA0Uue/qYVHXYholHBtUkPRPP3/lixos88x14OJrTA5cWavzvIRHdipB
         IPBBcIyMn8oXamlNg/U7Um+5Ve46TzC8RK4ChcJ9CCyIhi9LETNCURZzQpv5V3t5Sovh
         QdHVGTaod2hU5MgeTepkk4HJfvHaODNz+6DjrNaaS6ncBQEE17PFJ2qQ8++ANF6i+qCy
         AIu5LRYRWe9Zljk/34JE/tS2+hexVWlL1HiRy6RNCx69BBGmZYGg7LQJMRXEUCSQAmS6
         5PEezMl2HiUS3Q+pYF2iGefhlp+2vKww6UUUZZwOmTNJtJ8jOwnJDK/w2v+BsUf27H6s
         etwA==
X-Gm-Message-State: APjAAAX5mRtCzUKZ1cVmrxRZ6bWQ31e1Z52uvnvekGHgA8U5jw0eVbGu
	XKON4VZy7oPZ+Fzp56T7lD6OdMnLspn8UruR39AN6g==
X-Google-Smtp-Source: APXvYqyXr3lS+JZj9aYaGZcaZ677aNc3G5lICFsM5cpGfCF42dv3olbejurJoFC1AmwOnpAVRiOEEAY2CuZWxYa6P3Q=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr3079638otq.126.1579198173237;
 Thu, 16 Jan 2020 10:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20200106181117.GA16248@redhat.com> <20200116145403.GB25291@redhat.com>
In-Reply-To: <20200116145403.GB25291@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 16 Jan 2020 10:09:22 -0800
Message-ID: <CAPcyv4hNQ3qtF1CA5Bb3NkSyUbw+_3CCY2e97EMXS4jfHTF7ag@mail.gmail.com>
Subject: Re: dax: Get rid of fs_dax_get_by_host() helper
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: UN7AR6W5VE2GDK4ZUFQTSIME44Z4NNHH
X-Message-ID-Hash: UN7AR6W5VE2GDK4ZUFQTSIME44Z4NNHH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UN7AR6W5VE2GDK4ZUFQTSIME44Z4NNHH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 16, 2020 at 6:54 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Jan 06, 2020 at 01:11:17PM -0500, Vivek Goyal wrote:
> > Looks like nobody is using fs_dax_get_by_host() except fs_dax_get_by_bdev()
> > and it can easily use dax_get_by_host() instead.
> >
> > IIUC, fs_dax_get_by_host() was only introduced so that one could compile
> > with CONFIG_FS_DAX=n and CONFIG_DAX=m. fs_dax_get_by_bdev() achieves
> > the same purpose and hence it looks like fs_dax_get_by_host() is not
> > needed anymore.
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>
> Hi Dan,
>
> Ping for this patch. How does it look to you. If you don't have concerns,
> can you please take it in your tree.

Yes, looks good and applied.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
