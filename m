Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5EC2D3895
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 03:09:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 97341100EB847;
	Tue,  8 Dec 2020 18:09:54 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7BE15100EB846
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 18:09:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j13so39958pjz.3
        for <linux-nvdimm@lists.01.org>; Tue, 08 Dec 2020 18:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=UBQIONZ0hiRZEX45td2zbbDAEz5jWMsRaPeE5x/dG9Y=;
        b=l2c5a5zJYWODtRE69w8EPO4BXm9EHC2Rmhyxiesti8IgoNWActdU1SKkXw3s4sv01z
         dz9T5pNOm3k84ZqdYmg6Tg83TxXKAC8aqN9RZx3xYSYnU4IKrez8s/rUsvLJHPQ6LajF
         xDipXDqa1fT5VAgEAswDEH+pdRXDce+Gp4F0yvBVPps7BjDnCW7bEbqCl6xZ7PKu56iw
         LsCn8OXq01O6LpCGCzslOECo+OuOLNY8TgfdAlxD+EiEYvfyYIWn7w7d0zpHiElPOcTH
         vH7cghaoPr/ylfBPOMughhur8+9kMYz3UBLX6R273RcJdNWeLrlGiU8HTWzCCTx2IGVX
         w1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UBQIONZ0hiRZEX45td2zbbDAEz5jWMsRaPeE5x/dG9Y=;
        b=OYkDhmoO/bRISb+4mKNvFuewVky//8gXkNhDXtPVnOmTVqHveQXjpscZUT+3kjjcpQ
         YD4hH/jJLiLoObFzu0+z4fWBhx9Q3YnFtrlt0o5QF+65t5Z2IY522KOdAXI/nKcQyNQy
         Dodadfy7OHRIoxrKhzXuoX/gLv/yBVKcIbXoCu39jnqFA7VQ7EXyYQqG7sUl1cw3HKtc
         r3ZvYcKyML+8Qp7CwMJ+M+trWLC//B/DCXlh0g71Xfwqg86chzim446KU7G8MqJSyndl
         xzcT39ic+SFRI9pyHRAJEBMmMnyQ95jpYBdlAtgq06wG7UP481qufHzqauMyH9Fw6rOG
         n1rQ==
X-Gm-Message-State: AOAM531BEfUK34x8FjyHrG/ZtmqCb+S9fYG7SmigAeEGfKmzaYj96N3q
	d4vU7zOC67yJprR9xNxofCTBoQ==
X-Google-Smtp-Source: ABdhPJzyQH7xhvlufl1pTIVH8zBoyexXgZ+QOG48g0KnyyyC3prNuE6s8H2uLXbwNniXmiGvhQEzTw==
X-Received: by 2002:a17:90b:243:: with SMTP id fz3mr106743pjb.41.1607479791731;
        Tue, 08 Dec 2020 18:09:51 -0800 (PST)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id w73sm118425pfd.203.2020.12.08.18.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 18:09:51 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl RFC v4 1/3] libndctl: test enablement for non-nfit devices
In-Reply-To: <CAPcyv4gP-jg1ckg-34fAHmSqhPkr1Q2QOyr9vxe2abJpVrcdkQ@mail.gmail.com>
References: <20201108121723.2089939-1-santosh@fossix.org>
 <20201108122016.2090891-1-santosh@fossix.org>
 <CAPcyv4gP-jg1ckg-34fAHmSqhPkr1Q2QOyr9vxe2abJpVrcdkQ@mail.gmail.com>
Date: Wed, 09 Dec 2020 07:39:48 +0530
Message-ID: <87zh2n4tn7.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: 4DCE6KCGUGXS3AVR4LNTOFUHFDEYCZ5H
X-Message-ID-Hash: 4DCE6KCGUGXS3AVR4LNTOFUHFDEYCZ5H
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4DCE6KCGUGXS3AVR4LNTOFUHFDEYCZ5H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Sun, Nov 8, 2020 at 4:21 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>>
>> Don't fail is nfit module is missing, this will happen in
>> platforms that don't have ACPI support. Add attributes to
>> PAPR dimm family that are independent of platforms like the
>> test dimms.
>>
>> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
>> ---
>>  ndctl/lib/libndctl.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>>  test/core.c          |  6 +++++
>>  2 files changed, 58 insertions(+)
>>
>> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
>> index ad521d3..d1f8e4e 100644
>> --- a/ndctl/lib/libndctl.c
>> +++ b/ndctl/lib/libndctl.c
>> @@ -1655,6 +1655,54 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
>>  static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
>>  static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
>>
>> +static void populate_dimm_attributes(struct ndctl_dimm *dimm,
>> +                                    const char *dimm_base)
>> +{
>> +       char buf[SYSFS_ATTR_SIZE];
>> +       struct ndctl_ctx *ctx = dimm->bus->ctx;
>> +       char *path = calloc(1, strlen(dimm_base) + 100);
>> +
>> +       sprintf(path, "%s/phys_id", dimm_base);
>> +       if (sysfs_read_attr(ctx, path, buf) < 0)
>> +               goto err_read;
>> +       dimm->phys_id = strtoul(buf, NULL, 0);
>> +
>> +       sprintf(path, "%s/handle", dimm_base);
>> +       if (sysfs_read_attr(ctx, path, buf) < 0)
>> +               goto err_read;
>> +       dimm->handle = strtoul(buf, NULL, 0);
>> +
>> +       sprintf(path, "%s/vendor", dimm_base);
>> +       if (sysfs_read_attr(ctx, path, buf) == 0)
>> +               dimm->vendor_id = strtoul(buf, NULL, 0);
>> +
>> +       sprintf(path, "%s/id", dimm_base);
>> +       if (sysfs_read_attr(ctx, path, buf) == 0) {
>> +               unsigned int b[9];
>> +
>> +               dimm->unique_id = strdup(buf);
>> +               if (!dimm->unique_id)
>> +                       goto err_read;
>> +               if (sscanf(dimm->unique_id, "%02x%02x-%02x-%02x%02x-%02x%02x%02x%02x",
>> +                                       &b[0], &b[1], &b[2], &b[3], &b[4],
>> +                                       &b[5], &b[6], &b[7], &b[8]) == 9) {
>> +                       dimm->manufacturing_date = b[3] << 8 | b[4];
>> +                       dimm->manufacturing_location = b[2];
>> +               }
>> +       }
>> +       sprintf(path, "%s/subsystem_vendor", dimm_base);
>> +       if (sysfs_read_attr(ctx, path, buf) == 0)
>> +               dimm->subsystem_vendor_id = strtoul(buf, NULL, 0);
>> +
>> +
>> +       sprintf(path, "%s/dirty_shutdown", dimm_base);
>> +       if (sysfs_read_attr(ctx, path, buf) == 0)
>> +               dimm->dirty_shutdown = strtoll(buf, NULL, 0);
>
> These are fairly similar to the nfit ones... how about refactoring
> this into a routine that takes a bus prefix and shares it between
> "nfit" and "papr"...
>
> We might also consider unifying them into a standard set of attributes
> that both the nfit-bus-provider and the papr-bus-provider export. I.e.
> that nfit was wrong to place them under nfit/ and they should have
> went somewhere generic from the beginning. The nfit compatibility can
> be done with symlinks to the new common location.
>
>> +
>> +err_read:
>> +       free(path);
>> +}
>> +
>>  static int add_papr_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
>>  {
>>         int rc = -ENODEV;
>> @@ -1685,6 +1733,10 @@ static int add_papr_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
>>                 rc = 0;
>>         }
>>
>> +       /* add the available dimm attributes, the platform can override or add
>> +        * additional attributes later */
>> +       populate_dimm_attributes(dimm, dimm_base);
>> +
>>         free(path);
>>         return rc;
>>  }
>> diff --git a/test/core.c b/test/core.c
>> index 5118d86..0fd1011 100644
>> --- a/test/core.c
>> +++ b/test/core.c
>> @@ -195,6 +195,12 @@ retry:
>>
>>                 path = kmod_module_get_path(*mod);
>>                 if (!path) {
>> +                       /* For non-nfit platforms it's ok if nfit module is
>> +                        * missing */
>> +                       if (strcmp(name, "nfit") == 0 ||
>> +                           strcmp(name, "nd_e820") == 0)
>> +                               continue;
>
> This breaks the safety it afforded on nfit platforms. Instead I think
> this needs a couple changes:
>
> - rename nfit_test_init to ndctl_test_init
> - add a parameter for whether the test is initializing for
> nfit_test.ko or ndtest.ko.

Thanks for review Dan. I will make changes accordingly and send newer version
without -ENOCOMMITMESSAGE error.

Since I posted this only for the comments on the approach I took, I think I got
how to proceed in terms on ndctl changes atleast. I will send a v5 soon enough.

Thanks,
Santosh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
