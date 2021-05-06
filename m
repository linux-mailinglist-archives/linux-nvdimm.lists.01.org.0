Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9485F374DCF
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 05:05:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF834100EB835;
	Wed,  5 May 2021 20:05:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=yizhan@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F2C5C100EF271
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 20:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620270318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1UGUTqov9VcCYmfqJqFm9kBZntv58uwigGcuOXUM90A=;
	b=O5XjsDwvqq0eezVigCQvToLmzrzr5tJW9Xf+rXRazMlf6akr1HQIHIJzob+Fw4wJJGNQgg
	AFc4YAyTy+US4Lgi0p+9k7nEsYcfgdzhijAFYi+UpbO+nfnckxbsozvb2/tspIalwJRh1T
	MHwpBQMA4sFO8H5+5DSgA7RJdtgACSE=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-DtXhjLsnO12BBjioE-sCpA-1; Wed, 05 May 2021 23:05:17 -0400
X-MC-Unique: DtXhjLsnO12BBjioE-sCpA-1
Received: by mail-yb1-f200.google.com with SMTP id r2-20020a25ac420000b02904f5a9b7d37fso4531521ybd.22
        for <linux-nvdimm@lists.01.org>; Wed, 05 May 2021 20:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UGUTqov9VcCYmfqJqFm9kBZntv58uwigGcuOXUM90A=;
        b=mh4Y/BWlrfwR7Z4mvUPQ11GceEk2YEi58Bq9PoCTDQB/sSqWueZN5+DtaCTNkw3yJ4
         d2IHMfL6T5HLfljAHOmWukuaih7ETt4MoBnP517pRENaA37mC1NDakJcnOBcuIo7KJLW
         zM3Hwe2hawSps8j0+1ced02o6XsoA6Q9HZb5fQ6naW3IFUqZWnlaFy8Wc+9r7W6U8RXy
         YCxasV52c76/dc/CHbshRrR6Fsz3xcsxFhSPZ47/yxtNIPiOOkrKrN1u/6zWet9e+kte
         C1PmTX30wW5i7kyQNh3fyM3PZOgWXs++FwkE5c4Tb6XUSSK6lV1h5+IB4x+iokmjyeL6
         GVCw==
X-Gm-Message-State: AOAM532XvFcty3O7hhnwT3ROaNEKCFq795liwf2umG9a0Wu066SDnMxz
	D7YW6H8mJTZUpjXHBd5f4rxuY5gN1uOogEgvwS24x0r3UfSYg2nVSNQQYmUi2jCHrpG1oXlwp3x
	tABb3s5fa5+q1eOq1p+RyylsHHgIvAlBO3pyU
X-Received: by 2002:a25:4093:: with SMTP id n141mr2612238yba.133.1620270316593;
        Wed, 05 May 2021 20:05:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRGutdTGsda5OTOMaza2owNPNtQjAIWPZPwchL+NSb3AKBGyBFsWHRhcQ759xG5KJXWlDh0o5auYqXOfAPwII=
X-Received: by 2002:a25:4093:: with SMTP id n141mr2612118yba.133.1620270315041;
 Wed, 05 May 2021 20:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9s25EqRhL6_D5Rg_7j14N5UVODJ0ps4=4n7sZ6zE5U3w@mail.gmail.com>
 <CAPcyv4iuA=+aUOgHvYXtg8D_1RSxjrZC4cG2GXVhEZVeQCD5rA@mail.gmail.com>
In-Reply-To: <CAPcyv4iuA=+aUOgHvYXtg8D_1RSxjrZC4cG2GXVhEZVeQCD5rA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 6 May 2021 11:05:04 +0800
Message-ID: <CAHj4cs_Zp85ePses2CxuNyoh5FAObWxOuWGAmmOeZ1KOTQ6msQ@mail.gmail.com>
Subject: Re: [bug report] system panic at nfit_get_smbios_id+0x6e/0xf0 [nfit]
 during boot
To: Dan Williams <dan.j.williams@intel.com>, robert.moore@intel.com
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: QVJHWAXQX2M7ETMQL7RQCWVYDHVUNW4M
X-Message-ID-Hash: QVJHWAXQX2M7ETMQL7RQCWVYDHVUNW4M
X-MailFrom: yizhan@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, erik.kaneda@intel.com, rafael.j.wysocki@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QVJHWAXQX2M7ETMQL7RQCWVYDHVUNW4M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, May 1, 2021 at 2:05 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Apr 30, 2021 at 7:28 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > Hi
> >
> > With the latest Linux tree, my DCPMM server boot failed with the
> > bellow panic log, pls help check it, let me know if you need any test
> > for it.
>
> So v5.12 is ok but v5.12+ is not?
>
> Might you be able to bisect?

Hi Dan
This issue was introduced with this patch, let me know if you need more info.

commit cf16b05c607bd716a0a5726dc8d577a89fdc1777
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Apr 6 14:30:15 2021 -0700

    ACPICA: ACPI 6.4: NFIT: add Location Cookie field

    Also, update struct size to reflect these changes in nfit core driver.

    ACPICA commit af60199a9a1de9e6844929fd4cc22334522ed195

    Link: https://github.com/acpica/acpica/commit/af60199a
    Cc: Dan Williams <dan.j.williams@intel.com>
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>
> If not can you send the nfit.gz from this command:
>
> acpidump -n NFIT | gzip -c > nfit.gz
>
> Also can you send the full dmesg? I don't suppose you see a message of
> this format before this failure:
>
>                         dev_err(acpi_desc->dev, "SPA %d missing DCR %d\n",
>                                         spa->range_index, dcr);
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
