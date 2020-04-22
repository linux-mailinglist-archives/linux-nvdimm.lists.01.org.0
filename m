Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40AA1B50F7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Apr 2020 01:43:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D186F10FC33E2;
	Wed, 22 Apr 2020 16:43:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F0145100780B4
	for <linux-nvdimm@lists.01.org>; Wed, 22 Apr 2020 16:43:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id re23so3269128ejb.4
        for <linux-nvdimm@lists.01.org>; Wed, 22 Apr 2020 16:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcrDXAYtAPdQ5qlr1w8aWOfD6suyITb3nozV7/vzPs4=;
        b=l9tOGiMK8o7Mu5XIESoWMJHYlfzAtLOQ9+trUjWkvdQw7kVjnETJCP6UU5bFXTVW9F
         WmYijYz9MEIBbiBn9MZfB05ZZlHIOtFQGooSfe2X6rY2dmLv8JaAE/0LZt8L8+Rj2P8r
         tQLHg2/vDTumfQmgQ88klpcTd4tMLVgXeX0B8pUhK0480t++npX8zFksPl3j1K8vgNmi
         1x1EoD369gPVZupnlGOjozOydyxNKdyHNJqMzpkzr+6NyCzvRMwSJ6XiICVjRwDzy3Yu
         8uEUCBciprc7GJkoGncLSVto801Zy5/r7O4u9v50nmQZ/yMB2dpOc2QPMrrIwqdy94xc
         JpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcrDXAYtAPdQ5qlr1w8aWOfD6suyITb3nozV7/vzPs4=;
        b=P3ZB5uGfV7YS4yjbtIaWh1oWiPDHSUK6ZHn/VLgwKaNIDsDlTOL5NaaezxqG15jGSw
         wJeghTJSz7jQOWCgLDgQlIfOjKqFcRwGdtUR3IiFdXSL/oHcs3mPlxae2dmUhh+aOMIM
         pQafo+FbSnWbEwsfb2ne8PnizAKShpvUKrXVD0lQ8q+NNWC/4JxDtN68CFEKLJe+nHt7
         Q/5j6NEzn7auBiBFjm6C6hg4oAitEpnegWaTtYOy88NIvSZJCKDZS1KjWmBDTUaP+U3D
         z69mwTdBB5WI/96gI4GlD7C9tfc7tBJMFg4AvTt12xNwk8AsPvR4W7x6vT3KOenLha9n
         cvzw==
X-Gm-Message-State: AGi0PubVdL18AeTxhg5HxYABE46aTMOMxetChIEflET9HMOWW4CyM4lw
	+utfHF5bBchqZ7ra10uFPkeerTx9Tr/rfKC8qEAQKw==
X-Google-Smtp-Source: APiQypIOEeepupEQDkA8AfIEujhoowVoegCdGbcNWfcI9RhvjFCnYP8EX/9Xwb3Lr1RROcSHy42ZnGiuuOj0gEiN5fI=
X-Received: by 2002:a17:906:bb07:: with SMTP id jz7mr536589ejb.317.1587599009465;
 Wed, 22 Apr 2020 16:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200422130539.45636-1-andriy.shevchenko@linux.intel.com> <20200422171023.GJ3372712@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200422171023.GJ3372712@iweiny-DESK2.sc.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 22 Apr 2020 16:43:18 -0700
Message-ID: <CAPcyv4gvxSBn_1n3JCRHTTSNqpfiS4OQ24jUzzraicjw5g1C_g@mail.gmail.com>
Subject: Re: [PATCH v1] libnvdimm: Replace guid_copy() with import_guid()
 where it makes sense
To: Ira Weiny <ira.weiny@intel.com>
Message-ID-Hash: PUTDVRNTU43I7U7QLYEGCZA3KMM64BLO
X-Message-ID-Hash: PUTDVRNTU43I7U7QLYEGCZA3KMM64BLO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PUTDVRNTU43I7U7QLYEGCZA3KMM64BLO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 22, 2020 at 10:10 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Wed, Apr 22, 2020 at 04:05:39PM +0300, Andy Shevchenko wrote:
> > There is a specific API to treat raw data as GUID, i.e. import_guid().
> > Use it instead of guid_copy() with explicit casting.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Looks good, applied for 5.8.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
