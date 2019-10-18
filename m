Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84EADCEC3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 20:55:00 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B45F910FCB38A;
	Fri, 18 Oct 2019 11:57:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5FE0F10FCB389
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 11:57:02 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z6so5849609otb.2
        for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvsx2AvcKxSbMaNB833x80IF/Z9NSQilfUtBUVNFIcs=;
        b=E4cZ4PIOwIZLkMnJuOhVyyZ0dGJlTJ279vUZEhH2uJuY0vTXxHP2gasMI379SUQaNK
         Kxo0OGozRCVt1PdoxBFn9s+0LE3wGyN2v7PJQILahcxfMe4Sls129fWAJEqu0VOFyHlI
         ZAR1/ZTpzUgkaE2fG6MxTuamgZ0KtTc6aruFkiv2s4HpU8Sphs3MY11l6OYYUJPcMNKk
         Y6Ns6VK4udVMwBA1uPLXowzqIgABYe9F47rxFrY1VIvkfsfkL9Y9FSZe2uNw8iVthDwf
         jA2dG49Sj98pJz/RDSs9X59tUfCqV160pMAcgfijlp9OaHa9sHwJYUyTa5ICa0bryvSj
         Fj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvsx2AvcKxSbMaNB833x80IF/Z9NSQilfUtBUVNFIcs=;
        b=eh1RCXN+MAXmaL9rGA2i+CT2aOZsoqZ/ze1ZlFuTedCM18EFVmjD1oqmTp8EWkDgR4
         JC34NUMAQ2mN9D8q3RT4MXtvnOBPQnk68We8aNWFh2QeOQ7QwC5VxZR3jx8PaHv8/fK4
         gNnG8VTe8fpFzrISUj1XoX9CuSEkUKfwMF5Y+IGP70c20I4UcHKxiiXQTdkCO4VWMWvX
         QdABcY3vksbG4/iGxgugLIyxHzv4HSn2fK5mk0JGJh2BsKvHLHslUKZ0cxIDKySe4Yt+
         FkA+d32CLptz7UjFYBjweoHXzEiM22/94VH0dwzoRVfGLn27VoDySk6Q7RLzoTGOt2cz
         UC4w==
X-Gm-Message-State: APjAAAWqzvpv1EqlY/V56/QqoWoWaQzW6r0TO5QtBUAcdYFlPV5Gfv8I
	vyBTnN70n1+2Z/Byy+znD7ZEweoE/Ngyo8ovMhJArg==
X-Google-Smtp-Source: APXvYqy7Fm6fwdYWEVRidG+NA27sHCDjR55NXqL6wrKXc0OVyzE5LPA+dNurK1E+EzsP6oAfp7wO4kJ+DaiUDBLwEz4=
X-Received: by 2002:a9d:3ee:: with SMTP id f101mr8713176otf.126.1571424895548;
 Fri, 18 Oct 2019 11:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191002234925.9190-1-vishal.l.verma@intel.com> <20191002234925.9190-5-vishal.l.verma@intel.com>
In-Reply-To: <20191002234925.9190-5-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Oct 2019 11:54:44 -0700
Message-ID: <CAPcyv4hb7vPbWhb3R5fyJH0H5OqRmhtVr=_D0tiYrkc_r8HpaQ@mail.gmail.com>
Subject: Re: [ndctl PATCH 04/10] libdaxctl: add an API to determine if memory
 is movable
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: DWXZHWDPMLCU3NW4M22TRPJBVFRNWTWL
X-Message-ID-Hash: DWXZHWDPMLCU3NW4M22TRPJBVFRNWTWL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ben Olson <ben.olson@intel.com>, Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DWXZHWDPMLCU3NW4M22TRPJBVFRNWTWL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2019 at 4:49 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> By default, daxctl always attempts to online new memory sections as
> 'movable' so that routine kernel allocations aren't serviced from this
> memory, and the memory is later removable via hot-unplug.
>
> System configuration, or other agents (such as udev rules) may race
> 'daxctl' to online memory, and this may result in the memory not being
> 'movable'. Add an interface to query the movability of a memory object
> associated with a dax device.
>
> This is in preparation to both display a 'movable' attribute in device
> listings, as well as optionally allowing memory to be onlined as
> non-movable.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Ben Olson <ben.olson@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  daxctl/lib/libdaxctl-private.h | 20 +++++++++
>  daxctl/lib/libdaxctl.c         | 77 ++++++++++++++++++++++++++++++++--
>  daxctl/lib/libdaxctl.sym       |  5 +++
>  daxctl/libdaxctl.h             |  1 +
>  4 files changed, 100 insertions(+), 3 deletions(-)
>
> diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
> index 7ba3c46..82939bb 100644
> --- a/daxctl/lib/libdaxctl-private.h
> +++ b/daxctl/lib/libdaxctl-private.h
> @@ -44,6 +44,25 @@ enum memory_op {
>         MEM_SET_ONLINE,
>         MEM_IS_ONLINE,
>         MEM_COUNT,
> +       MEM_FIND_ZONE,

This is private so the naming is not too big a concern, but isn't this
a MEM_GET_ZONE? A find operation to me is something that can succeed
to find nothing, whereas a get operation fail assumes the association
can always be retrieved barring exceptional conditions.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
