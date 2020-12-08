Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FAD2D1F9F
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 01:54:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 61F85100EBB9C;
	Mon,  7 Dec 2020 16:54:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 92A96100EBB9B
	for <linux-nvdimm@lists.01.org>; Mon,  7 Dec 2020 16:54:25 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ga15so22230175ejb.4
        for <linux-nvdimm@lists.01.org>; Mon, 07 Dec 2020 16:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O9Ljz2CX6PmkxdkkytRGD21+6+ovkmrkrH5sYvGUqSA=;
        b=fY2O7iKAKS1idqegr8ckD+BEsPJHt7ZKxpUO8Lxl4h5mTl/Zy7Ood5K5ki4aA5U7Zu
         /f4ieAuXHa2zvsRweccNUEWBlU3EXgXJLWNbM4PCnVQkH2Ti9LUtDloh8OfqWX+FMlcD
         Kd+UGculbJa/BI6N948CrX3pyLee06c47U5tWZ1BQgL8+Uxd5S7v0B92eKLN/cFiOgr4
         2uEPjV4H5KeETzpzfWhSOfHt/q4enqsITzRr5derGvYXqcQQ2GFn6MwgAK/gMnnYplDY
         yYps0B7Gb+PVF+IKKUJsH2mDjqgXZfgfDC1dHySg5fc7rhnVvWMXLHWfrtY97KlAZ7Nz
         FFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9Ljz2CX6PmkxdkkytRGD21+6+ovkmrkrH5sYvGUqSA=;
        b=jbLbsBskRzeT/o96tS/I/cU/C656MUbJt1c885kH9X3UpyLNHczavl3mt7rpqncEz3
         aQhSYmT/21gPdaGK9RrQN7H9MNv5vWnneytcwtRukLci8U9E4c4SueKXDlXE4Jgu2cyo
         /4Ia4MiXUc4zrOhmiet3rr1yM8lJp9xojVXqLlOBk2AGnj+DWdp5caqsO8u961lG0qRv
         N+Li1JoQ/ouC0rM8Or7NErLg4wAQ7WdDpLAtAjNi7JHc7Vw4HpyBUNDkhjAvz+jhpCKA
         xZd9rd7pkdc57u3jaP6ZLAXqKNmKxqgcOGxrQO+NxP2U13Qo3TXzrOQh8fnUoTLs120L
         YtYA==
X-Gm-Message-State: AOAM530opO10BRP/iuoA+96z/AqKA8mNURAcR62k0Fz8UGCyMFNZSsW+
	GPgHW3kPeY6LOcW1Ni8ncUcJ2zTlIwl+bsEc63lB+qmq1SY=
X-Google-Smtp-Source: ABdhPJx5IHKEuf6kHbQH5LExn+Dj7vCgfdVf9fM58IltvGIEMqiFxKGoXM/HGB2RMLVJ+/IFhna53PO5iE5pzZo6V/E=
X-Received: by 2002:a17:906:518a:: with SMTP id y10mr21614856ejk.323.1607388863459;
 Mon, 07 Dec 2020 16:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20201108211549.122018-1-vaibhav@linux.ibm.com>
In-Reply-To: <20201108211549.122018-1-vaibhav@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 7 Dec 2020 16:54:21 -0800
Message-ID: <CAPcyv4h0PAPyYoea2oxqw_mOZ-Ec-o1MwcdSN0gf5UXqZqjafQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] libnvdimm: Introduce ND_CMD_GET_STAT to retrieve
 nvdimm statistics
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: ZWR6P6ILQSFMX75CS52KGEEMTNSLFCVG
X-Message-ID-Hash: ZWR6P6ILQSFMX75CS52KGEEMTNSLFCVG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZWR6P6ILQSFMX75CS52KGEEMTNSLFCVG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ add perf maintainers ]

On Sun, Nov 8, 2020 at 1:16 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Implement support for exposing generic nvdimm statistics via newly
> introduced dimm-command ND_CMD_GET_STAT that can be handled by nvdimm
> command handler function and provide values for these statistics back
> to libnvdimm. Following generic nvdimm statistics are defined as an
> enumeration in 'uapi/ndctl.h':
>
> * "media_reads" : Number of media reads that have occurred since reboot.
> * "media_writes" : Number of media writes that have occurred since reboot.
> * "read_requests" : Number of read requests that have occurred since reboot.
> * "write_requests" : Number of write requests that have occurred since reboot.

Perhaps document these as "since device reset"? As I can imagine some
devices might have a mechanism to reset the count outside of "reboot"
which is a bit ambiguous.

> * "total_media_reads" : Total number of media reads that have occurred.
> * "total_media_writes" : Total number of media writes that have occurred.
> * "total_read_requests" : Total number of read requests that have occurred.
> * "total_write_requests" : Total number of write requests that have occurred.
>
> Apart from ND_CMD_GET_STAT ioctl these nvdimm statistics are also
> exposed via sysfs '<nvdimm-device>/stats' directory for easy user-space
> access like below:
>
> /sys/class/nd/ndctl0/device/nmem0/stats # tail -n +1 *
> ==> media_reads <==
> 252197707602
> ==> media_writes <==
> 20684685172
> ==> read_requests <==
> 658810924962
> ==> write_requests <==
> 404464081574

Hmm, I haven't looked but how hard would it be to plumb these to be
perf counter-events. So someone could combine these with other perf
counters?

> In case a specific nvdimm-statistic is not supported than nvdimm
> command handler function can simply return an error (e.g -ENOENT) for
> request to read that nvdimm-statistic.

Makes sense, but I expect the perf route also has a way to enumerate
which statistics / counters are supported. I'm not opposed to also
having them in sysfs, but I think perf support should be a first class
citizen.

>
> The value for a specific nvdimm-stat is exchanged via newly introduced
> 'struct nd_cmd_get_dimm_stat' that hold a single statistics and a
> union of possible values types. Presently only '__s64' type of generic
> attributes are supported. These attributes are defined in
> 'ndvimm/dimm_devs.c' via a helper macro 'NVDIMM_STAT_ATTR'.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  drivers/nvdimm/bus.c       |   6 ++
>  drivers/nvdimm/dimm_devs.c | 109 +++++++++++++++++++++++++++++++++++++
>  drivers/nvdimm/nd.h        |   5 ++
>  include/uapi/linux/ndctl.h |  27 +++++++++
>  4 files changed, 147 insertions(+)
>
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 2304c6183822..d53564477437 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -794,6 +794,12 @@ static const struct nd_cmd_desc __nd_cmd_dimm_descs[] = {
>                 .out_num = 1,
>                 .out_sizes = { UINT_MAX, },
>         },
> +       [ND_CMD_GET_STAT] = {
> +               .in_num = 1,
> +               .in_sizes = { sizeof(struct nd_cmd_get_dimm_stat), },
> +               .out_num = 1,
> +               .out_sizes = { sizeof(struct nd_cmd_get_dimm_stat), },
> +       },
>  };
>
>  const struct nd_cmd_desc *nd_cmd_dimm_desc(int cmd)
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index b59032e0859b..68aaa294def7 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -555,6 +555,114 @@ static umode_t nvdimm_firmware_visible(struct kobject *kobj, struct attribute *a
>         return a->mode;
>  }
>
> +/* Request a dimm stat from the bus driver */
> +static int __request_dimm_stat(struct nvdimm_bus *nvdimm_bus,
> +                              struct nvdimm *dimm, u64 stat_id,
> +                              s64 *stat_val)
> +{
> +       struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
> +       struct nd_cmd_get_dimm_stat stat = { .stat_id = stat_id };
> +       int rc, cmd_rc;
> +
> +       if (!test_bit(ND_CMD_GET_STAT, &dimm->cmd_mask)) {
> +               pr_debug("CMD_GET_STAT not set for bus driver 0x%lx\n",
> +                        nd_desc->cmd_mask);
> +               return -ENOENT;
> +       }
> +
> +       /* Is stat requested is known & bus driver supports fetching stats */
> +       if (stat_id <= ND_DIMM_STAT_INVALID || stat_id > ND_DIMM_STAT_MAX) {
> +               WARN(1, "Unknown stat-id(%llu) requested", stat_id);
> +               return -ENOENT;
> +       }
> +
> +       /* Ask bus driver for its stat value */
> +       rc = nd_desc->ndctl(nd_desc, dimm, ND_CMD_GET_STAT,
> +                           &stat, sizeof(stat), &cmd_rc);
> +       if (rc || cmd_rc) {
> +               pr_debug("Unable to request stat %lld. Error (%d,%d)\n",
> +                        stat_id, rc, cmd_rc);
> +               return rc ? rc : cmd_rc;
> +       }
> +
> +       /* Indicate error in case returned struct doesn't have the stat_id set */
> +       if (stat.stat_id != stat_id) {
> +               pr_debug("Invalid statid %llu returned\n", stat.stat_id);
> +               return -ENOENT;
> +       }
> +
> +       *stat_val = stat.int_val;
> +       return 0;
> +}
> +
> +static ssize_t nvdimm_stat_attr_show(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    char *buf)
> +{
> +       struct nvdimm_stat_attr *nattr = container_of(attr, typeof(*nattr), attr);
> +       struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
> +       struct nvdimm *nvdimm = to_nvdimm(dev);
> +       s64 stat_val;
> +       int rc;
> +
> +       rc = __request_dimm_stat(nvdimm_bus, nvdimm, nattr->stat_id, &stat_val);
> +
> +       if (rc)
> +               return rc;
> +
> +       return snprintf(buf, PAGE_SIZE, "%lld", stat_val);
> +}
> +
> +static umode_t nvdimm_stats_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +       struct nvdimm_stat_attr *nattr = container_of(a, typeof(*nattr), attr.attr);
> +       struct device *dev = container_of(kobj, typeof(*dev), kobj);
> +       struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
> +       struct nvdimm *nvdimm = to_nvdimm(dev);
> +       u64 stat_val;
> +       int rc;
> +
> +       /* request dimm stat from bus driver and is success mark attribute as visible */
> +       rc = __request_dimm_stat(nvdimm_bus, nvdimm, nattr->stat_id, &stat_val);
> +       if (rc)
> +               pr_info("Unable to query stat %llu . Error(%d)\n", nattr->stat_id, rc);
> +
> +       return rc ? 0 : a->mode;
> +}
> +
> +#define NVDIMM_STAT_ATTR(_name, _stat_id)                              \
> +       struct nvdimm_stat_attr nvdimm_stat_attr_##_name = {                    \
> +               .attr = __ATTR(_name, 0400, nvdimm_stat_attr_show, NULL), \
> +               .stat_id = _stat_id,                                    \
> +       }
> +
> +static NVDIMM_STAT_ATTR(media_reads, ND_DIMM_STAT_MEDIA_READS);
> +static NVDIMM_STAT_ATTR(media_writes,  ND_DIMM_STAT_MEDIA_WRITES);
> +static NVDIMM_STAT_ATTR(read_requests, ND_DIMM_STAT_READ_REQUESTS);
> +static NVDIMM_STAT_ATTR(write_requests, ND_DIMM_STAT_WRITE_REQUESTS);
> +static NVDIMM_STAT_ATTR(total_media_reads, ND_DIMM_STAT_TOTAL_MEDIA_READS);
> +static NVDIMM_STAT_ATTR(total_media_writes, ND_DIMM_STAT_TOTAL_MEDIA_WRITES);
> +static NVDIMM_STAT_ATTR(total_read_requests, ND_DIMM_STAT_TOTAL_READ_REQUESTS);
> +static NVDIMM_STAT_ATTR(total_write_requests,  ND_DIMM_STAT_TOTAL_WRITE_REQUESTS);
> +
> +static struct attribute *nvdimm_stats_attributes[] = {
> +       &nvdimm_stat_attr_media_reads.attr.attr,
> +       &nvdimm_stat_attr_media_writes.attr.attr,
> +       &nvdimm_stat_attr_read_requests.attr.attr,
> +       &nvdimm_stat_attr_write_requests.attr.attr,
> +       &nvdimm_stat_attr_total_media_reads.attr.attr,
> +       &nvdimm_stat_attr_total_media_writes.attr.attr,
> +       &nvdimm_stat_attr_total_read_requests.attr.attr,
> +       &nvdimm_stat_attr_total_write_requests.attr.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group nvdimm_stats_group = {
> +       .name = "stats",
> +       .attrs = nvdimm_stats_attributes,
> +       .is_visible = nvdimm_stats_visible,
> +};
> +
>  static const struct attribute_group nvdimm_firmware_attribute_group = {
>         .name = "firmware",
>         .attrs = nvdimm_firmware_attributes,
> @@ -565,6 +673,7 @@ static const struct attribute_group *nvdimm_attribute_groups[] = {
>         &nd_device_attribute_group,
>         &nvdimm_attribute_group,
>         &nvdimm_firmware_attribute_group,
> +       &nvdimm_stats_group,
>         NULL,
>  };
>
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index 696b55556d4d..ea9e846ae245 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -223,6 +223,11 @@ enum nd_async_mode {
>         ND_ASYNC,
>  };
>
> +struct nvdimm_stat_attr {
> +       struct device_attribute attr;
> +       u64 stat_id;
> +};
> +
>  int nd_integrity_init(struct gendisk *disk, unsigned long meta_size);
>  void wait_nvdimm_bus_probe_idle(struct device *dev);
>  void nd_device_register(struct device *dev);
> diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
> index 8cf1e4884fd5..81b76986b423 100644
> --- a/include/uapi/linux/ndctl.h
> +++ b/include/uapi/linux/ndctl.h
> @@ -97,6 +97,31 @@ struct nd_cmd_clear_error {
>         __u64 cleared;
>  } __packed;
>
> +/* Various generic dimm stats that can be reported */
> +enum {
> +       ND_DIMM_STAT_INVALID = 0,
> +       ND_DIMM_STAT_MEDIA_READS = 1,  /* Media reads after power cycle */
> +       ND_DIMM_STAT_MEDIA_WRITES = 2, /* Media writes after power cycle */
> +       ND_DIMM_STAT_READ_REQUESTS = 3, /* Read requests after power cycle */
> +       ND_DIMM_STAT_WRITE_REQUESTS = 4, /* Write requests after power cycle */
> +       ND_DIMM_STAT_TOTAL_MEDIA_READS = 5, /* Total Media Reads */
> +       ND_DIMM_STAT_TOTAL_MEDIA_WRITES = 6, /* Total Media Writes */
> +       ND_DIMM_STAT_TOTAL_READ_REQUESTS = 7, /* Total Read Requests */
> +       ND_DIMM_STAT_TOTAL_WRITE_REQUESTS = 8, /* Total Write  Requests */
> +       ND_DIMM_STAT_MAX = 8,
> +};
> +
> +struct nd_cmd_get_dimm_stat {
> +       /* See enum above for valid values */
> +       __u64 stat_id;
> +
> +       /* Holds a single dimm stat value */
> +       union {
> +               __s64 int_val;
> +               char  str_val[120];
> +       };
> +} __packed;

Is this needed? Especially if perf has the counters, and sysfs
optionally has the counters, does the ioctl path also need to be
plumbed?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
