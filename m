Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D003830D087
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Feb 2021 01:54:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3F593100EAB61;
	Tue,  2 Feb 2021 16:54:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 87377100EAB5E
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 16:54:45 -0800 (PST)
IronPort-SDR: fajQIJ+VcRju2j94BNwjmHRCE0Ksmobdwij48MRa9Uztp82/CmjC2k8r3aeMua0W7LtsbRZedq
 QN2fgt4mS2Ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="177455079"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="177455079"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 16:54:44 -0800
IronPort-SDR: T/OKYfRyJECY92tbmhe95trHnlElgkP/dg1d1yQ7hUQWoAcmWXv06c4utLZaKcN9E5eW0I+84+
 WVBgh83fvJ6A==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="371036464"
Received: from rebbutt-mobl3.amr.corp.intel.com (HELO intel.com) ([10.252.133.20])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 16:54:43 -0800
Date: Tue, 2 Feb 2021 16:54:40 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
Message-ID: <20210203005440.yyyphe4yigf3fvkc@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-5-ben.widawsky@intel.com>
 <5986abe5-1248-30b2-5f53-fa7013baafad@google.com>
 <CAPcyv4g_yUpwoBJsLeVwCZAkZGGrfSgrCk2+GXVXBcouktZNSQ@mail.gmail.com>
 <20210202225733.miq5sl3mqit2zuhg@intel.com>
 <CAPcyv4gPbN74wOzPH5-qC6a1V5ZwXUVedtr0ZJmfP8DA13YWnA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gPbN74wOzPH5-qC6a1V5ZwXUVedtr0ZJmfP8DA13YWnA@mail.gmail.com>
Message-ID-Hash: ZMNPWUYZHMUGAOB7NYOY7LZ3MAACKWXQ
X-Message-ID-Hash: ZMNPWUYZHMUGAOB7NYOY7LZ3MAACKWXQ
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Rientjes <rientjes@google.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZMNPWUYZHMUGAOB7NYOY7LZ3MAACKWXQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-02 15:54:03, Dan Williams wrote:
> On Tue, Feb 2, 2021 at 2:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-02-01 12:00:18, Dan Williams wrote:
> > > On Sat, Jan 30, 2021 at 3:52 PM David Rientjes <rientjes@google.com> wrote:
> > > >
> > > > On Fri, 29 Jan 2021, Ben Widawsky wrote:
> > > >
> > > > > Provide enough functionality to utilize the mailbox of a memory device.
> > > > > The mailbox is used to interact with the firmware running on the memory
> > > > > device.
> > > > >
> > > > > The CXL specification defines separate capabilities for the mailbox and
> > > > > the memory device. The mailbox interface has a doorbell to indicate
> > > > > ready to accept commands and the memory device has a capability register
> > > > > that indicates the mailbox interface is ready. The expectation is that
> > > > > the doorbell-ready is always later than the memory-device-indication
> > > > > that the mailbox is ready.
> > > > >
> > > > > Create a function to handle sending a command, optionally with a
> > > > > payload, to the memory device, polling on a result, and then optionally
> > > > > copying out the payload. The algorithm for doing this comes straight out
> > > > > of the CXL 2.0 specification.
> > > > >
> > > > > Primary mailboxes are capable of generating an interrupt when submitting
> > > > > a command in the background. That implementation is saved for a later
> > > > > time.
> > > > >
> > > > > Secondary mailboxes aren't implemented at this time.
> > > > >
> > > > > The flow is proven with one implemented command, "identify". Because the
> > > > > class code has already told the driver this is a memory device and the
> > > > > identify command is mandatory.
> > > > >
> > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > ---
> > > > >  drivers/cxl/Kconfig |  14 ++
> > > > >  drivers/cxl/cxl.h   |  39 +++++
> > > > >  drivers/cxl/mem.c   | 342 +++++++++++++++++++++++++++++++++++++++++++-
> > > > >  3 files changed, 394 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > > > index 3b66b46af8a0..fe591f74af96 100644
> > > > > --- a/drivers/cxl/Kconfig
> > > > > +++ b/drivers/cxl/Kconfig
> > > > > @@ -32,4 +32,18 @@ config CXL_MEM
> > > > >         Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
> > > > >
> > > > >         If unsure say 'm'.
> > > > > +
> > > > > +config CXL_MEM_INSECURE_DEBUG
> > > > > +     bool "CXL.mem debugging"
> > > > > +     depends on CXL_MEM
> > > > > +     help
> > > > > +       Enable debug of all CXL command payloads.
> > > > > +
> > > > > +       Some CXL devices and controllers support encryption and other
> > > > > +       security features. The payloads for the commands that enable
> > > > > +       those features may contain sensitive clear-text security
> > > > > +       material. Disable debug of those command payloads by default.
> > > > > +       If you are a kernel developer actively working on CXL
> > > > > +       security enabling say Y, otherwise say N.
> > > >
> > > > Not specific to this patch, but the reference to encryption made me
> > > > curious about integrity: are all CXL.mem devices compatible with DIMP?
> > > > Some?  None?
> > >
> > > The encryption here is "device passphrase" similar to the NVDIMM
> > > Security Management described here:
> > >
> > > https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf
> > >
> > > The LIBNVDIMM enabling wrapped this support with the Linux keys
> > > interface which among other things enforces wrapping the clear text
> > > passphrase with a Linux "trusted/encrypted" key.
> > >
> > > Additionally, the CXL.io interface optionally supports PCI IDE:
> > >
> > > https://www.intel.com/content/dam/www/public/us/en/documents/reference-guides/pcie-device-security-enhancements.pdf
> > >
> > > I'm otherwise not familiar with the DIMP acronym?
> > >
> > > > > +
> > > > >  endif
> > > > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > > > index a3da7f8050c4..df3d97154b63 100644
> > > > > --- a/drivers/cxl/cxl.h
> > > > > +++ b/drivers/cxl/cxl.h
> > > > > @@ -31,9 +31,36 @@
> > > > >  #define CXLDEV_MB_CAPS_OFFSET 0x00
> > > > >  #define   CXLDEV_MB_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> > > > >  #define CXLDEV_MB_CTRL_OFFSET 0x04
> > > > > +#define   CXLDEV_MB_CTRL_DOORBELL BIT(0)
> > > > >  #define CXLDEV_MB_CMD_OFFSET 0x08
> > > > > +#define   CXLDEV_MB_CMD_COMMAND_OPCODE_MASK GENMASK(15, 0)
> > > > > +#define   CXLDEV_MB_CMD_PAYLOAD_LENGTH_MASK GENMASK(36, 16)
> > > > >  #define CXLDEV_MB_STATUS_OFFSET 0x10
> > > > > +#define   CXLDEV_MB_STATUS_RET_CODE_MASK GENMASK(47, 32)
> > > > >  #define CXLDEV_MB_BG_CMD_STATUS_OFFSET 0x18
> > > > > +#define CXLDEV_MB_PAYLOAD_OFFSET 0x20
> > > > > +
> > > > > +/* Memory Device (CXL 2.0 - 8.2.8.5.1.1) */
> > > > > +#define CXLMDEV_STATUS_OFFSET 0x0
> > > > > +#define   CXLMDEV_DEV_FATAL BIT(0)
> > > > > +#define   CXLMDEV_FW_HALT BIT(1)
> > > > > +#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
> > > > > +#define     CXLMDEV_MS_NOT_READY 0
> > > > > +#define     CXLMDEV_MS_READY 1
> > > > > +#define     CXLMDEV_MS_ERROR 2
> > > > > +#define     CXLMDEV_MS_DISABLED 3
> > > > > +#define   CXLMDEV_READY(status) \
> > > > > +             (CXL_GET_FIELD(status, CXLMDEV_STATUS_MEDIA_STATUS) == CXLMDEV_MS_READY)
> > > > > +#define   CXLMDEV_MBOX_IF_READY BIT(4)
> > > > > +#define   CXLMDEV_RESET_NEEDED_SHIFT 5
> > > > > +#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
> > > > > +#define     CXLMDEV_RESET_NEEDED_NOT 0
> > > > > +#define     CXLMDEV_RESET_NEEDED_COLD 1
> > > > > +#define     CXLMDEV_RESET_NEEDED_WARM 2
> > > > > +#define     CXLMDEV_RESET_NEEDED_HOT 3
> > > > > +#define     CXLMDEV_RESET_NEEDED_CXL 4
> > > > > +#define   CXLMDEV_RESET_NEEDED(status) \
> > > > > +             (CXL_GET_FIELD(status, CXLMDEV_RESET_NEEDED) != CXLMDEV_RESET_NEEDED_NOT)
> > > > >
> > > > >  /**
> > > > >   * struct cxl_mem - A CXL memory device
> > > > > @@ -44,6 +71,16 @@ struct cxl_mem {
> > > > >       struct pci_dev *pdev;
> > > > >       void __iomem *regs;
> > > > >
> > > > > +     struct {
> > > > > +             struct range range;
> > > > > +     } pmem;
> > > > > +
> > > > > +     struct {
> > > > > +             struct range range;
> > > > > +     } ram;
> > > > > +
> > > > > +     char firmware_version[0x10];
> > > > > +
> > > > >       /* Cap 0001h - CXL_CAP_CAP_ID_DEVICE_STATUS */
> > > > >       struct {
> > > > >               void __iomem *regs;
> > > > > @@ -51,6 +88,7 @@ struct cxl_mem {
> > > > >
> > > > >       /* Cap 0002h - CXL_CAP_CAP_ID_PRIMARY_MAILBOX */
> > > > >       struct {
> > > > > +             struct mutex mutex; /* Protects device mailbox and firmware */
> > > > >               void __iomem *regs;
> > > > >               size_t payload_size;
> > > > >       } mbox;
> > > > > @@ -89,5 +127,6 @@ struct cxl_mem {
> > > > >
> > > > >  cxl_reg(status);
> > > > >  cxl_reg(mbox);
> > > > > +cxl_reg(mem);
> > > > >
> > > > >  #endif /* __CXL_H__ */
> > > > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > > > index fa14d51243ee..69ed15bfa5d4 100644
> > > > > --- a/drivers/cxl/mem.c
> > > > > +++ b/drivers/cxl/mem.c
> > > > > @@ -6,6 +6,270 @@
> > > > >  #include "pci.h"
> > > > >  #include "cxl.h"
> > > > >
> > > > > +#define cxl_doorbell_busy(cxlm)                                                \
> > > > > +     (cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET) &                    \
> > > > > +      CXLDEV_MB_CTRL_DOORBELL)
> > > > > +
> > > > > +#define CXL_MAILBOX_TIMEOUT_US 2000
> > > >
> > > > This should be _MS?
> > > >
> > > > > +
> > > > > +enum opcode {
> > > > > +     CXL_MBOX_OP_IDENTIFY            = 0x4000,
> > > > > +     CXL_MBOX_OP_MAX                 = 0x10000
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * struct mbox_cmd - A command to be submitted to hardware.
> > > > > + * @opcode: (input) The command set and command submitted to hardware.
> > > > > + * @payload_in: (input) Pointer to the input payload.
> > > > > + * @payload_out: (output) Pointer to the output payload. Must be allocated by
> > > > > + *            the caller.
> > > > > + * @size_in: (input) Number of bytes to load from @payload.
> > > > > + * @size_out: (output) Number of bytes loaded into @payload.
> > > > > + * @return_code: (output) Error code returned from hardware.
> > > > > + *
> > > > > + * This is the primary mechanism used to send commands to the hardware.
> > > > > + * All the fields except @payload_* correspond exactly to the fields described in
> > > > > + * Command Register section of the CXL 2.0 spec (8.2.8.4.5). @payload_in and
> > > > > + * @payload_out are written to, and read from the Command Payload Registers
> > > > > + * defined in (8.2.8.4.8).
> > > > > + */
> > > > > +struct mbox_cmd {
> > > > > +     u16 opcode;
> > > > > +     void *payload_in;
> > > > > +     void *payload_out;
> > > > > +     size_t size_in;
> > > > > +     size_t size_out;
> > > > > +     u16 return_code;
> > > > > +#define CXL_MBOX_SUCCESS 0
> > > > > +};
> > > > > +
> > > > > +static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> > > > > +{
> > > > > +     const int timeout = msecs_to_jiffies(CXL_MAILBOX_TIMEOUT_US);
> > > > > +     const unsigned long start = jiffies;
> > > > > +     unsigned long end = start;
> > > > > +
> > > > > +     while (cxl_doorbell_busy(cxlm)) {
> > > > > +             end = jiffies;
> > > > > +
> > > > > +             if (time_after(end, start + timeout)) {
> > > > > +                     /* Check again in case preempted before timeout test */
> > > > > +                     if (!cxl_doorbell_busy(cxlm))
> > > > > +                             break;
> > > > > +                     return -ETIMEDOUT;
> > > > > +             }
> > > > > +             cpu_relax();
> > > > > +     }
> > > > > +
> > > > > +     dev_dbg(&cxlm->pdev->dev, "Doorbell wait took %dms",
> > > > > +             jiffies_to_msecs(end) - jiffies_to_msecs(start));
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> > > > > +                              struct mbox_cmd *mbox_cmd)
> > > > > +{
> > > > > +     dev_warn(&cxlm->pdev->dev, "Mailbox command timed out\n");
> > > > > +     dev_info(&cxlm->pdev->dev,
> > > > > +              "\topcode: 0x%04x\n"
> > > > > +              "\tpayload size: %zub\n",
> > > > > +              mbox_cmd->opcode, mbox_cmd->size_in);
> > > > > +
> > > > > +     if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
> > > > > +             print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
> > > > > +                                  mbox_cmd->payload_in, mbox_cmd->size_in,
> > > > > +                                  true);
> > > > > +     }
> > > > > +
> > > > > +     /* Here's a good place to figure out if a device reset is needed */
> > > >
> > > > What are the implications if we don't do a reset, as this implementation
> > > > does not?  IOW, does a timeout require a device to be recovered through a
> > > > reset before it can receive additional commands, or is it safe to simply
> > > > drop the command that timed out on the floor and proceed?
> > >
> > > Not a satisfying answer, but "it depends". It's also complicated by
> > > the fact that a reset may need to be coordinated with other devices in
> > > the interleave-set as the HDM decoders may bounce.
> > >
> > > For comparison, to date there have been no problems with the "drop on
> > > the floor" policy of LIBNVDIMM command timeouts. At the same time
> > > there simply was not a software visible reset mechanism for those
> > > devices so this problem never came out. This mailbox isn't a fast
> > > path, so the device is likely completely dead if this timeout is ever
> > > violated, and the firmware reporting a timeout might as well assume
> > > that the OS gives up on the device.
> > >
> > > I'll let Ben chime in on the rest...
> >
> > Reset handling is next on the TODO list for the driver. I had two main reasons
> > for not even taking a stab at it.
> > 1. I have no good way to test it. We are working on adding some test conditions
> >    to QEMU for it.
> > 2. The main difficulty in my mind with reset is you can't pull the memory out
> >    from under the OS here. While the driver doesn't yet handle persistent memory
> >    capacities, it may have volatile capacity configured by the BIOS. So the goal
> >    was, get the bits of the driver in that would at least allow developers,
> >    hardware vendors, and folks contributing to the spec a way to have basic
> >    interaction with a CXL type 3 device.
> 
> Honestly I think in most cases if the firmware decides to return a
> "reset required" status the Linux response will be "lol, no" because
> the firmware has no concept of the violence that would impose on the
> rest of the system.

How about UAPI to initiate a reset? I think a sysfs bool would do the trick.
Maybe sysfs file to display current error status, and one to reset?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
