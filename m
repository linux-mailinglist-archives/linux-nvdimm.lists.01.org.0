Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C5FDCE87
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 20:46:07 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DDAB710FCB384;
	Fri, 18 Oct 2019 11:48:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A2C1A10FCB383
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 11:48:09 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m19so5842993otp.1
        for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9ffWUce4+kObRVvhJ6n/yINSZCparJV/3JVrntUOpA=;
        b=Yod/43l32W8c1sclBov8FbkvsBKc9C0W0nlmkHkMIHOtAOiEf+PAce8Wr8WRQ3+0l4
         tGvUnoRPvX2HymjsygojoNwUe2d+lL9dNwKgerK6no+8B9+sgig932prScMCg+za6lUE
         4UBXWXk58vSV32f0QDcnl4cDou4sLhKDGQTzh5aN4h93Dg5929DQgMCKxz4HQgfHZtEn
         h2dsHmlxuzlMJ8311w43P8BUPwDUlG2yLVSJaVNPfFaKcXv/tv2x0EkdllpPfIBIew6x
         yr7jfGraUjdhp9s/0qhTGXxa0ZeiWsaJawdgOgXH1MkS+g+bukJEIh3k7JVvlCp+GDTX
         9vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9ffWUce4+kObRVvhJ6n/yINSZCparJV/3JVrntUOpA=;
        b=I4JlfWG0aI11/+UVgn6NnGZkooVlEcoW6IjbJ44G5c97Iv7uBGuQwVXFM5jJi/NMMX
         13Uzlj6luMFhmW+J6QiTM2wgRNJJsnWq02Gh72SwF2GMI1i5tDJlyrfVmAym0ARxJ6Dh
         SS5JiKjXKjkVuKstky23KbVXMzsdeWpevgUeTbBeBtlDoZvnyjk5yEhHkfWGZL11mzFE
         33a8wKW1EBQ/8+fprC+FZU8/4DYNKCUrxwa9TOkWAiaLxvGI6nyIAm/o0DbnF/oNUIV0
         vJSg33GkZ9v2HBqNi2kyvRZepcZmxvX6AoDs5FEqF/+DKjIzWaVNMOJ4Xr35ILUzZDi/
         XtPg==
X-Gm-Message-State: APjAAAWRRGIIVq6vMKsYuCbYBCuVtgrjep/mUPj09JN/vwm/EAa3XXEJ
	bSzBJ8Av4UeVJZZWdXHsoTQyrfEkkjgbkZ+e8+nxYQ==
X-Google-Smtp-Source: APXvYqzxqaCFBIN7eLzv5tqNGCQKb+7za6q/H731j1JNbC8UIIPX++/bcVEKN0XOd9apYGwgyZ++ZZ+38b+4E+OjrfY=
X-Received: by 2002:a05:6830:15ca:: with SMTP id j10mr1289027otr.247.1571424362927;
 Fri, 18 Oct 2019 11:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191002234925.9190-1-vishal.l.verma@intel.com> <20191002234925.9190-3-vishal.l.verma@intel.com>
In-Reply-To: <20191002234925.9190-3-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Oct 2019 11:45:51 -0700
Message-ID: <CAPcyv4hjBsjR-vx2OJ6J1u51_jvhZYVe89u-6kjQVHANWiNaDQ@mail.gmail.com>
Subject: Re: [ndctl PATCH 02/10] libdaxctl: refactor memblock_is_online() checks
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: ZWD2WZJZ5VMOUXNGQM5QRFFORU2MO2PN
X-Message-ID-Hash: ZWD2WZJZ5VMOUXNGQM5QRFFORU2MO2PN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ben Olson <ben.olson@intel.com>, Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZWD2WZJZ5VMOUXNGQM5QRFFORU2MO2PN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2019 at 4:49 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> The {online,offline}_one_memblock() helpers both open-coded the check
> for whether a block is online. There is already a function to perform
> this check - memblock_is_online(). Consolidate the checking using this
> helper everywhere it is applicable.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  daxctl/lib/libdaxctl.c | 90 +++++++++++++++++-------------------------
>  1 file changed, 37 insertions(+), 53 deletions(-)

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
